create sequence sq_pk_media_creator;

create table tb_media_creator (
    media_creator integer primary key default nextval( 'sq_pk_media_creator'::regclass ),
    name          text    not null unique
);

create sequence sq_pk_aesthetic_media;

create table tb_aesthetic_media (
    aesthetic_media      integer primary key default nextval( 'sq_pk_aesthetic_media'::regclass ),
    aesthetic            integer not null references tb_aesthetic,
    media_file           integer not null references tb_file,
    media_thumbnail_file integer not null references tb_file,
    media_preview_file   integer not null references tb_file,
    label                text,
    description          text,
    media_creator        integer references tb_media_creator,
    year                 integer,
    created              timestamp not null default now(),
    creator              integer not null references tb_entity,
    modified             timestamp not null default now(),
    modifier             integer not null references tb_entity,
    unique ( aesthetic, media_file )
);
