create sequence if not exists sq_pk_aesthetic;

create table if not exists tb_aesthetic (
    aesthetic   integer    primary key default nextval( 'sq_pk_aesthetic'::regclass ),
    name        text       not null unique,
    url_slug    text       not null unique,
    symbol      varchar(3) not null unique,
    start_year  integer    not null,
    end_year    integer,
    description text       not null
);

create table if not exists tb_website_type (
    website_type integer     primary key,
    label        varchar(50) not null unique
);

insert into tb_website_type ( website_type, label )
     values ( 1, 'Are.na' ),
            ( 2, 'Facebook Group' ),
            ( 3, 'Twitter' ),
            ( 4, 'Tumblr' )
on conflict do nothing;

create sequence if not exists sq_pk_website;

create table if not exists tb_website (
    website      integer primary key default nextval( 'sq_pk_website'::regclass ),
    url          text    not null unique,
    website_type integer not null
);

create sequence if not exists sq_pk_aesthetic_website;

create table if not exists tb_aesthetic_website (
    aesthetic_website integer primary key default nextval( 'sq_pk_aesthetic_website'::regclass ),
    aesthetic         integer not null references tb_aesthetic,
    website           integer not null references tb_website,
    unique ( aesthetic, website )
);

create sequence if not exists sq_pk_aesthetic_relationship;

-- description describes to_aesthetic's relation to from_aesthetic
create table if not exists tb_aesthetic_relationship (
    aesthetic_relationship integer primary key default nextval( 'sq_pk_aesthetic_relationship'::regclass ),
    from_aesthetic         integer not null references tb_aesthetic ( aesthetic ),
    to_aesthetic           integer not null references tb_aesthetic ( aesthetic ),
    description            text,
    unique ( from_aesthetic, to_aesthetic )
);

create sequence if not exists sq_pk_media;

create table if not exists tb_media (
    media             integer primary key default nextval( 'sq_pk_media'::regclass ),
    url               text not null,
    preview_image_url text,
    label             text,
    description       text,
    creator           integer references tb_media_creator ( media_creator ),
    year              integer
);

create sequence if not exists sq_pk_aesthetic_media;

create table if not exists tb_aesthetic_media (
    aesthetic_media integer primary key default nextval( 'sq_pk_aesthetic_media'::regclass ),
    aesthetic       integer not null references tb_aesthetic,
    media           integer not null references tb_media,
    unique ( aesthetic, media )
);

create sequence if not exists sq_pk_media_creator;

create table if not exists tb_media_creator (
    media_creator integer primary key default nextval( 'sq_pk_media_creator'::regclass ),
    name          text    not null unique
);
