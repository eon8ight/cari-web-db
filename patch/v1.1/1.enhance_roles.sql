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
