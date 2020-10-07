#!/usr/bin/python3

import csv
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
    description
) values (
    %(name)s,
    %(url_slug)s,
    %(start_year)s,
    %(end_year)s,
    %(description)s
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
   select %(from_aesthetic)s as from_aesthetic,
          aesthetic          as to_aesthetic,
          %(description)s    as description
     from tb_aesthetic
    where name = %(to_aesthetic_name)s
    union all
   select aesthetic          as from_aesthetic,
          %(from_aesthetic)s as to_aesthetic,
          null               as description
     from tb_aesthetic
    where name = %(to_aesthetic_name)s
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
      set description = trim(excluded.description || ' ' || ar.description)
returning aesthetic_relationship
'''


def query(db_handle, query, **kwargs):
    rval = []

    with db_handle.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
        cursor.execute(query, kwargs)
        rval = list(map(dict, cursor.fetchall()))

    return rval


def parse_csv_row(row, headers):
    rval = {}

    for key in ('name', 'start_year', 'end_year', 'description'):
        rval[key] = row[headers[key]]

    rval['websites'] = []

    for key in ('website_arena', 'website_facebook', 'website_twitter', 'website_tumblr'):
        websites = list(map(lambda v: v.strip(), row[headers[key]].split(',')))

        for website in websites:
            if website:
                website_type = key.split('_', 1)

                rval['websites'].append({
                    'url': website,
                    'website_type_label': website_type[1]
                })

    rval['aesthetic_relationships'] = {}

    aesthetic_relationships = list(map(
        lambda a: a.strip(), row[headers['similar_aesthetics']].split(',')))

    for aesthetic_relationship in aesthetic_relationships:
        aesthetic_relationship_match = re.match(
            r'([^()]+)\s*\(([^)]+)\)', aesthetic_relationship)

        if aesthetic_relationship_match:
            to_aesthetic_name = aesthetic_relationship_match.group(1).strip()
            description = aesthetic_relationship_match.group(2).strip()
            rval['aesthetic_relationships'][to_aesthetic_name] = description

    rval['url_slug'] = re.sub(r'\s+', '-', re.sub(r'[^a-zA-Z0-9\s]', '', rval['name'],
                                                  re.IGNORECASE)).lower()

    return rval


@click.command()
@click.option('-h', '--host', default='localhost', help='database server host or socket directory')
@click.option('-U', '--username', default='cari', help='database user name')
@click.option('-d', '--dbname', default='cari', help='database name to connect to')
@click.option('-p', '--port', default='5432', help='database server port')
@click.option('-W', '--password', help='force password prompt')
@click.argument('datafile', type=click.File('r'))
def main(host, username, dbname, port, password, datafile):
    csv_reader = csv.reader(datafile)

    psql_connection_args = {
        'dbname': dbname,
        'user': username,
        'host': host,
        'port': port,
    }

    if(password):
        psql_connection_args['password'] = password

    db_handle = psycopg2.connect(**psql_connection_args)

    header_row = next(csv_reader, None)
    headers = {
        header_row[i]: i
        for i in range(len(header_row))
    }

    aesthetic_relationships = {}

    for row in csv_reader:
        parsed_row = parse_csv_row(row, headers)

        aesthetic_row = {
            'name': parsed_row['name'],
            'url_slug': parsed_row['url_slug'],
            'start_year': parsed_row['start_year'],
            'end_year': parsed_row['end_year'],
            'description': parsed_row['description'],
        }

        pk_aesthetic = query(
            db_handle, INSERT_AESTHETIC_QUERY, **aesthetic_row)[0]['aesthetic']

        aesthetic_relationships[pk_aesthetic] = parsed_row['aesthetic_relationships']

        for website in parsed_row['websites']:
            query(db_handle, INSERT_WEBSITE_QUERY, **
                  {'aesthetic': pk_aesthetic, **website})

    for (aesthetic, aesthetic_relationship_list) in aesthetic_relationships.items():
        if aesthetic_relationship_list:
            for (to_aesthetic_name, description) in aesthetic_relationship_list.items():
                query(db_handle, INSERT_AESTHETIC_RELATIONSHIP_QUERY, from_aesthetic=aesthetic,
                      to_aesthetic_name=to_aesthetic_name, description=description)

    db_handle.commit()


if __name__ == '__main__':
    main()
