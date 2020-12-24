create sequence sq_pk_entity;

create table tb_entity (
    entity             integer   primary key default nextval( 'sq_pk_entity'::regclass ),
    email_address      text      not null unique,
    username           text      unique,
    password_hash      text,
    inviter            integer   not null references tb_entity,
    invited            timestamp not null default now(),
    registered         timestamp,
    confirmed          timestamp,
    first_name         text,
    last_name          text,
    biography          text,
    title              text,
    profile_image_file integer references tb_file,
    favorite_aesthetic integer references tb_aesthetic
);

insert into tb_entity (
    entity,
    email_address,
    username,
    password_hash,
    inviter,
    invited,
    registered,
    confirmed,
    first_name,
    last_name
) values (
    0,
    'no-reply@c-a-r-i.org',
    'root',
    '',
    0,
    '1970-01-01 00:00:00',
    '1970-01-01 00:00:00',
    '1970-01-01 00:00:00',
    'System',
    'Entity'
);

create table tb_role (
    role  integer primary key,
    label varchar(50) not null unique
);

insert into tb_role ( role, label )
     values ( 1, 'Admin' ),
            ( 2, 'User' );

create sequence sq_pk_entity_role;

create table tb_entity_role (
    entity_role integer primary key default nextval( 'sq_pk_entity_role' ),
    entity      integer not null references tb_entity,
    role        integer not null references tb_role,
    unique ( entity, role )
);

insert into tb_entity_role ( entity, role )
     values ( 0, 1 );