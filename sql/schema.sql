create sequence sq_pk_aesthetic;

create table tb_aesthetic (
    aesthetic   integer primary key default nextval( 'sq_pk_aesthetic'::regclass ),
    name        text    not null unique,
    start_year  integer not null,
    end_year    integer,
    description text    not null
);

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

create table tb_relationship_type (
    relationship_type integer     primary key,
    label             varchar(50) not null unique
);

insert into tb_relationship_type ( relationship_type, label )
     values ( 1, 'Influenced' ),
            ( 2, 'Precursor' ),
            ( 3, 'Variant' ),
            ( 4, 'Shares Aspects' ),
            ( 5, 'Reactionary To' );

create sequence sq_pk_aesthetic_relationship;

-- Read as: {from_aesthetic} influenced {to_aesthetic}, {from_aesthetic} is a variant of {to_aesthetic}, etc.
create table tb_aesthetic_relationship (
    aesthetic_relationship integer primary key default nextval( 'sq_pk_aesthetic_relationship'::regclass );
    from_aesthetic         integer not null references tb_aesthetic ( aesthetic ),
    to_aesthetic           integer not null references tb_aesthetic ( aesthetic ),
    relationship_type      integer not null references tb_relationship_type
    unique ( from_aesthetic, to_aesthetic )
);
