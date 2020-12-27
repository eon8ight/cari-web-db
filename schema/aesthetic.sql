create table tb_era_specifier (
    era_specifier integer primary key,
    label         varchar(20) not null unique,
    weight        integer not null unique
);

insert into tb_era_specifier ( era_specifier, label, weight )
     values ( 1, 'Very Early', 1 ),
            ( 2, 'Early', 3 ),
            ( 3, 'Mid', 5 ),
            ( 4, 'Late', 7 ),
            ( 5, 'Very Late', 9 );

create table tb_era (
    era           integer primary key,
    era_specifier integer not null references tb_era_specifier,
    year          integer not null,
    unique ( era_specifier, year )
);

insert into tb_era (
    era,
    era_specifier,
    year
)
  select row_number() over(),
         es.era_specifier,
         y.year
    from tb_era_specifier es,
         ( values
           ( 1950 ),
           ( 1960 ),
           ( 1970 ),
           ( 1980 ),
           ( 1990 ),
           ( 2000 ),
           ( 2010 ),
           ( 2020 )
         ) as y ( year )
order by y.year, es.era_specifier;

create sequence sq_pk_aesthetic;

create table tb_aesthetic (
    aesthetic        integer primary key default nextval( 'sq_pk_aesthetic'::regclass ),
    name             text not null unique,
    url_slug         text not null unique,
    symbol           varchar(3) unique,
    start_era        integer references tb_era,
    end_era          integer references tb_era,
    description      text not null,
    media_source_url text,
    created          timestamp not null default now(),
    creator          integer not null references tb_entity,
    modified         timestamp not null default now(),
    modifier         integer not null references tb_entity
);

create sequence sq_pk_aesthetic_relationship;

-- description describes to_aesthetic's relation to from_aesthetic
create table tb_aesthetic_relationship (
    aesthetic_relationship integer primary key default nextval( 'sq_pk_aesthetic_relationship'::regclass ),
    from_aesthetic         integer not null references tb_aesthetic ( aesthetic ),
    to_aesthetic           integer not null references tb_aesthetic ( aesthetic ),
    description            text,
    created                timestamp not null default now(),
    creator                integer not null references tb_entity,
    modified               timestamp not null default now(),
    modifier               integer not null references tb_entity,
    unique ( from_aesthetic, to_aesthetic )
);
