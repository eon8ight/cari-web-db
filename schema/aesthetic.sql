create sequence sq_pk_aesthetic;

create table tb_aesthetic (
    aesthetic        integer    primary key default nextval( 'sq_pk_aesthetic'::regclass ),
    name             text       not null unique,
    url_slug         text       not null unique,
    symbol           varchar(3) unique,
    start_year       integer,
    peak_year        integer,
    description      text       not null,
    media_source_url text
);

create sequence sq_pk_aesthetic_relationship;

-- description describes to_aesthetic's relation to from_aesthetic
create table tb_aesthetic_relationship (
    aesthetic_relationship integer primary key default nextval( 'sq_pk_aesthetic_relationship'::regclass ),
    from_aesthetic         integer not null references tb_aesthetic ( aesthetic ),
    to_aesthetic           integer not null references tb_aesthetic ( aesthetic ),
    description            text,
    unique ( from_aesthetic, to_aesthetic )
);
