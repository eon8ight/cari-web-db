alter table tb_entity
    add column display_on_team_page boolean default false;

update tb_entity e
   set display_on_team_page = true
  from tb_entity_role er
  join tb_role r
    on er.role = r.role
 where e.entity = er.entity
   and r.label = 'Admin';

delete from tb_entity_role er
      using tb_role r
      where er.role = r.role
        and r.label = 'Admin';

insert into tb_entity_role (
    entity,
    role
)
select e.entity,
       r.role
  from tb_entity e,
       tb_role r
 where r.label = 'User'
    on conflict
    do nothing;