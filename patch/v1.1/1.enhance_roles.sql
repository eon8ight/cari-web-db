alter table tb_role
    add column rank integer unique;

update tb_role
   set rank = 1
 where label = 'Admin';

update tb_role
   set rank = 100000
 where label = 'User';

insert into tb_role ( role, label, rank )
     values ( 3, 'Lead Director', 10 ),
            ( 4, 'Lead Curator', 20 ),
            ( 5, 'Curator', 30 ),
            ( 6, 'Assistant Curator', 40 ),
            ( 7, 'Community Organizer', 50 ),
            ( 8, 'Webmaster', 60 ),
            ( 9, 'Web Developer', 70 );

insert into tb_entity_role (
    entity,
    role
)
select e.entity,
       v.role
  from (
         values ( 'alex.edwards', 7 ),
                ( 'alex.edwards', 5 ),
                ( 'chan.miller', 9 ),
                ( 'cindy.hernandez', 4 ),
                ( 'evan.collins', 4 ),
                ( 'froyo.tam', 3 ),
                ( 'jack.grimes', 5 ),
                ( 'max.krieger', 6 ),
                ( 'zovi.mcentee', 8 )
       ) as v ( entity_username, role )
  join tb_entity e
    on v.entity_username = e.username;

update tb_entity e
   set title = v.title
  from (
         values ( 'alex.edwards', null ),
                ( 'chan.miller', null ),
                ( 'cindy.hernandez', 'Design Historian' ),
                ( 'evan.collins', 'Architecture' ),
                ( 'froyo.tam', 'Transdisciplinary Design' ),
                ( 'jack.grimes', 'Designer' ),
                ( 'max.krieger', 'Interactive Media' ),
                ( 'zovi.mcentee', 'Project Manager' )
       ) as v ( entity_username, title )
 where v.entity_username = e.username;
