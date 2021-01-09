create table tb_http_method (
    http_method integer primary key,
    label       text    not null unique
);

insert into tb_http_method ( http_method, label )
     values ( 1, 'GET' ),
            ( 2, 'POST' ),
            ( 3, 'PUT' ),
            ( 4, 'DELETE' ),
            ( 5, 'PATCH' );

create sequence sq_pk_route;

create table tb_route (
    route       integer primary key default nextval( 'sq_pk_route'::regclass ),
    http_method integer not null references tb_http_method,
    url         text    not null unique
);

insert into tb_route (
    http_method,
    url
) values (
    2,
    '/user/edit'
), (
    2,
    '/user/invite'
), (
    2,
    '/aesthetic/edit'
);

create sequence sq_pk_role_route;

create table tb_role_route (
    role_route integer primary key not null default nextval( 'sq_pk_role_route'::regclass ),
    role       integer not null references tb_role,
    route      integer not null references tb_route,
    unique ( role, route )
);

insert into tb_role_route (
    role,
    route
)
select rl.role,
       ru.route
  from (
         values ( 'User', '/user/edit' ),
                ( 'User', '/user/invite' ),
                ( 'Lead Director', '/aesthetic/edit' ),
                ( 'Lead Curator', '/aesthetic/edit' ),
                ( 'Curator', '/aesthetic/edit' )
       ) v ( role_label, route_url )
  join tb_role rl
    on v.role_label = rl.label
  join tb_route ru
    on v.route_url = ru.url;