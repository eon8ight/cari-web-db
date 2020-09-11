create sequence sq_pk_media_creator;

create table tb_media_creator (
    media_creator integer primary key default nextval( 'sq_pk_media_creator'::regclass ),
    name          text    not null unique
);

create sequence sq_pk_media;

create table tb_media (
    media             integer primary key default nextval( 'sq_pk_media'::regclass ),
    url               text not null,
    preview_image_url text,
    label             text,
    description       text,
    media_creator     integer references tb_media_creator,
    year              integer
);

create sequence sq_pk_aesthetic_media;

create table tb_aesthetic_media (
    aesthetic_media integer primary key default nextval( 'sq_pk_aesthetic_media'::regclass ),
    aesthetic       integer not null references tb_aesthetic,
    media           integer not null references tb_media,
    unique ( aesthetic, media )
);
