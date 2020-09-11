create table tb_website_type (
    website_type integer     primary key,
    label        varchar(50) not null unique
);

insert into tb_website_type ( website_type, label )
     values ( 1, 'Are.na' ),
            ( 2, 'Facebook Group' ),
            ( 3, 'Twitter' ),
            ( 4, 'Tumblr' );

create sequence sq_pk_website;

create table tb_website (
    website      integer primary key default nextval( 'sq_pk_website'::regclass ),
    url          text    not null unique,
    website_type integer not null
);

create sequence sq_pk_aesthetic_website;

create table tb_aesthetic_website (
    aesthetic_website integer primary key default nextval( 'sq_pk_aesthetic_website'::regclass ),
    aesthetic         integer not null references tb_aesthetic,
    website           integer not null references tb_website,
    unique ( aesthetic, website )
);