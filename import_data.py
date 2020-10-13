#!/usr/bin/python3

from openpyxl import load_workbook
import re

import click
import psycopg2
import psycopg2.extras

INSERT_AESTHETIC_QUERY = '''
insert into tb_aesthetic (
    name,
    url_slug,
    start_year,
    end_year,
    description,
    media_source_url
) values (
    %(name)s,
    %(url_slug)s,
    %(start_year)s,
    %(end_year)s,
    %(description)s,
    %(media_source_url)s
) returning aesthetic
'''

INSERT_WEBSITE_QUERY = '''
with tt_website as (
    insert into tb_website (
        url,
        website_type
    )
       select %(url)s,
              website_type
         from tb_website_type
        where regexp_replace(label, '[^a-zA-Z0-9]', '', 'g') ilike %(website_type_label)s || '%%'
    returning website
)
insert into tb_aesthetic_website as aw (
    aesthetic,
    website
)
   select %(aesthetic)s,
          ttaw.website
     from tt_website ttaw
returning website
'''

INSERT_AESTHETIC_RELATIONSHIP_QUERY = '''
with tt_aesthetic_relationship as (
    select from_a.aesthetic as from_aesthetic,
           to_a.aesthetic   as to_aesthetic,
           %(description)s  as description
      from tb_aesthetic from_a,
           tb_aesthetic to_a
     where from_a.name = %(from_aesthetic_name)s
       and to_a.name = %(to_aesthetic_name)s
     union all
    select to_a.aesthetic          as from_aesthetic,
           from_a.aesthetic        as to_aesthetic,
           %(reverse_description)s as description
      from tb_aesthetic from_a,
           tb_aesthetic to_a
     where from_a.name = %(from_aesthetic_name)s
       and to_a.name = %(to_aesthetic_name)s
)
insert into tb_aesthetic_relationship as ar (
    from_aesthetic,
    to_aesthetic,
    description
)
   select ttar.from_aesthetic,
          ttar.to_aesthetic,
          ttar.description
     from tt_aesthetic_relationship ttar
       on conflict (from_aesthetic, to_aesthetic) do update
      set description = trim(excluded.description || '; ' || ar.description)
returning aesthetic_relationship
'''

INSERT_MEDIA_CREATOR_QUERY = '''
insert into tb_media_creator (
    name
) values (
    %(name)s
)
returning media_creator
'''

INSERT_MEDIA_QUERY = '''
with tt_media as (
    insert into tb_media (
        url,
        preview_image_url,
        label,
        description,
        media_creator,
        year
    ) values (
        %(url)s,
        %(preview_image_url)s,
        %(label)s,
        %(description)s,
        %(media_creator)s,
        %(year)s
    )
    returning media
)
insert into tb_aesthetic_media (
    aesthetic,
    media
)
   select a.aesthetic,
          ttm.media
     from tt_media ttm,
          tb_aesthetic a
    where a.name = %(aesthetic_name)s
returning aesthetic_media
'''


def query(db_handle, query, **kwargs):
    rval = []

    with db_handle.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
        cursor.execute(query, kwargs)
        rval = list(map(dict, cursor.fetchall()))

    return rval


def comma_split(value):
    return list(filter(lambda v: v != '', map(lambda v: v.strip(), value.split(',')))) if value else []


def parse_header_row(worksheet):
    return {
        col.value: col.col_idx - 1
        for col in worksheet[1]
    }


def parse_aesthetic_row(cells, headers):
    rval = {}

    for key in ('name', 'start_year', 'end_year', 'description'):
        rval[key] = cells[headers[key]].value

    if not rval['description']:
        rval['description'] = 'No description.'

    rval['websites'] = []

    websites_arena = comma_split(cells[headers['website_arena']].value)
    media_source_url = None

    if websites_arena:
        arena_slug = websites_arena[0].split(
            '/').pop()

        media_source_url = 'https://api.are.na/v2/channels/' + arena_slug

        for website_arena in websites_arena:
            rval['websites'].append({
                'url': website_arena,
                'website_type_label': 'arena'
            })

    rval['media_source_url'] = media_source_url

    for key in ('website_facebook', 'website_twitter', 'website_tumblr'):
        websites = comma_split(cells[headers[key]].value)

        for website in websites:
            if website:
                website_type = key.split('_', 1)

                rval['websites'].append({
                    'url': website,
                    'website_type_label': website_type[1]
                })

    rval['url_slug'] = re.sub(r'\s+', '-', re.sub(r'[^a-zA-Z0-9\s]', '', rval['name'],
                                                  re.IGNORECASE)).lower()

    return rval


def parse_media_row(cells, headers):
    rval = {}

    rval['aesthetic_name'] = cells[headers['aesthetic']].value
    rval['media_creator_name'] = cells[headers['creator']].value

    for key in ('url', 'preview_image_url', 'label', 'description', 'year'):
        rval[key] = cells[headers[key]].value

    return rval


def parse_similarity_row(cells, headers):
    rval = {}

    rval['from_aesthetic_name'] = cells[headers['from_aesthetic']].value
    rval['to_aesthetic_name'] = cells[headers['to_aesthetic']].value

    for key in ('description', 'reverse_description'):
        rval[key] = cells[headers[key]].value

    return rval


def process_aesthetics_sheet(worksheet, db_handle):
    headers = parse_header_row(worksheet)

    for cells in worksheet.iter_rows(min_row=2):
        parsed_row = parse_aesthetic_row(cells, headers)

        aesthetic_row = {
            'name': parsed_row['name'],
            'url_slug': parsed_row['url_slug'],
            'start_year': parsed_row['start_year'],
            'end_year': parsed_row['end_year'],
            'description': parsed_row['description'],
            'media_source_url': parsed_row['media_source_url'],
        }

        pk_aesthetic = query(
            db_handle, INSERT_AESTHETIC_QUERY, **aesthetic_row)[0]['aesthetic']

        for website in parsed_row['websites']:
            query(db_handle, INSERT_WEBSITE_QUERY, **
                  {'aesthetic': pk_aesthetic, **website})


def process_timeline_sheet(worksheet, db_handle):
    headers = parse_header_row(worksheet)
    media_creators = {}

    for cells in worksheet.iter_rows(min_row=2):
        parsed_row = parse_media_row(cells, headers)

        media_row = {
            'aesthetic_name': parsed_row['aesthetic_name'],
            'url': parsed_row['url'],
            'preview_image_url': parsed_row['preview_image_url'],
            'label': parsed_row['label'],
            'description': parsed_row['description'],
            'year': parsed_row['year'],
        }

        creator_name = parsed_row.get('media_creator_name')

        if creator_name:
            if not media_creators.get(creator_name):
                media_creators[creator_name] = query(
                    db_handle, INSERT_MEDIA_CREATOR_QUERY, name=creator_name)[0]['media_creator']

            media_row['media_creator'] = media_creators[creator_name]
        else:
            media_row['media_creator'] = None

        query(db_handle, INSERT_MEDIA_QUERY, **media_row)


def process_similarity_sheet(worksheet, db_handle):
    headers = parse_header_row(worksheet)
    aesthetics = {}

    for cells in worksheet.iter_rows(min_row=2):
        parsed_row = parse_similarity_row(cells, headers)
        query(db_handle, INSERT_AESTHETIC_RELATIONSHIP_QUERY, **parsed_row)


@click.command()
@click.option('-h', '--host', default='localhost', help='database server host or socket directory')
@click.option('-U', '--username', default='cari', help='database user name')
@click.option('-d', '--dbname', default='cari', help='database name to connect to')
@click.option('-p', '--port', default='5432', help='database server port')
@click.option('-W', '--password', help='force password prompt')
@click.argument('datafile', type=click.Path(exists=True))
def main(host, username, dbname, port, password, datafile):
    workbook = load_workbook(filename=datafile, data_only=True)

    psql_connection_args = {
        'dbname': dbname,
        'user': username,
        'host': host,
        'port': port,
    }

    if(password):
        psql_connection_args['password'] = password

    db_handle = psycopg2.connect(**psql_connection_args)

    worksheets = {
        workbook.sheetnames[i]: i
        for i in range(len(workbook.sheetnames))
    }

    workbook.active = worksheets['aesthetics']
    process_aesthetics_sheet(workbook.active, db_handle)

    workbook.active = worksheets['timeline']
    process_timeline_sheet(workbook.active, db_handle)

    workbook.active = worksheets['similarity']
    process_similarity_sheet(workbook.active, db_handle)

    db_handle.commit()


if __name__ == '__main__':
    main()