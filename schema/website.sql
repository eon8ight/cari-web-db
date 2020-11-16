create table tb_website_type (
    website_type     integer      primary key,
    label            varchar(50)  not null unique,
    validation_regex varchar(100) not null unique
);

insert into tb_website_type ( website_type, label, validation_regex )
     values ( 1, 'Are.na', '^(https?:\/\/)?(www[.])?are[.]na\/.+$' ),
            ( 2, 'Facebook Group', '^(https?:\/\/)?(www[.])?facebook[.]com\/groups\/.+$' ),
            ( 3, 'Twitter', '^(https?:\/\/)?(www[.])?twitter[.]com\/.+$' ),
            ( 4, 'Tumblr', '^(https?:\/\/)?.+[.]tumblr[.]com\/?' );

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