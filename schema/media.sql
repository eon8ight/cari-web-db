create sequence sq_pk_media_creator;

create table tb_media_creator (
    media_creator integer primary key default nextval( 'sq_pk_media_creator'::regclass ),
    name          text    not null unique
);

create sequence sq_pk_aesthetic_media;

create table tb_aesthetic_media (
    aesthetic_media   integer primary key default nextval( 'sq_pk_aesthetic_media'::regclass ),
    aesthetic         integer not null references tb_aesthetic,
    url               text not null unique,
    preview_image_url text not null,
    label             text,
    description       text,
    media_creator     integer references tb_media_creator,
    year              integer,
    unique ( aesthetic, url )
);
