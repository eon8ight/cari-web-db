create sequence sq_pk_entity;

create table tb_entity (
    entity        integer   primary key default nextval( 'sq_pk_entity'::regclass ),
    email_address text      not null unique,
    username      text      unique,
    password_hash text,
    inviter       integer   not null references tb_entity,
    invited       timestamp not null default now(),
    registered    timestamp,
    confirmed     timestamp
);

insert into tb_entity (
    entity,
    email_address,
    username,
    password_hash,
    inviter,
    invited,
    registered,
    confirmed
) values (
    0,
    'no-reply@c-a-r-i.org',
    'System Entity',
    '',
    0,
    '1970-01-01 00:00:00',
    '1970-01-01 00:00:00',
    '1970-01-01 00:00:00'
);
