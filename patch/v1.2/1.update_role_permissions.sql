insert into tb_route (
    http_method,
    url
)
select http_method,
       '/aestheticMedia/edit'
  from tb_http_method
 where label = 'POST';

insert into tb_role_route (
    role,
    route
)
select rl.role,
       ru.route
  from tb_role rl,
       tb_route ru
 where rl.label = 'Curator'
   and ru.url = '/aestheticMedia/edit';

delete from tb_role_route rr
      using tb_role rl,
            tb_route ru
      where rr.role = rl.role
        and rr.route = ru.route
        and rl.label = 'Curator'
        and ru.url = '/aesthetic/edit';