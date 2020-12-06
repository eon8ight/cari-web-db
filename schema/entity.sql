create sequence sq_pk_entity;

create table tb_entity (
    entity        integer   primary key default nextval( 'sq_pk_entity'::regclass ),
    email_address text      not null unique,
    username      text      not null unique,
    password_hash text      not null,
    created       timestamp not null default now(),
    confirmed     timestamp
);