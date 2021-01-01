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
    title              text
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

insert into tb_entity (
    email_address,
    username,
    password_hash,
    inviter,
    invited,
    registered,
    confirmed,
    first_name,
    last_name,
    biography,
    title
) values (
    'hfuTuPdUqe@c-a-r-i.org',
    'froyo.tam',
    '',
    0,
    now(),
    now(),
    now(),
    'Froyo',
    'Tam',
    'Froyo Tam is a transmedia artist and curator, working across many disciplines in design, animation, and photography. She runs Y2K Aesthetic Institute''s Twitter, Instagram, and Tumblr along with Evan. Froyo also runs <a href="http://digicam.love" target="_blank noopener noreferrer">digicam.love</a> with Sofi Lee + Bao Ngo, curating digital photography on point-and-shoots, and is an active member of Arte Et Labore, a design collective run by Mark Robinson. Froyo is a graduate of Art Center College of Design in Pasadena, California with a BFA in graphic design. She is the finalist of the 2016 Adobe Design Achievement Awards in Social Impact. Her website can be found at: <a href="http://froyotam.info" target="_blank noopener noreferrer">froyotam.info</a>.',
    'Lead Director / Transdisciplinary Design'
),
(
    'tOndBhi13l@c-a-r-i.org',
    'cindy.hernandez',
    '',
    0,
    now(),
    now(),
    now(),
    'Cindy',
    'Hernandez',
    'Cindy Hernandez is a design historian and writer based in New York City. Her focus is on speculative and futuristic design ranging from the 20th century to today, with an affinity for the material culture space age, theme parks, and fast food chains. Cindy is a Master''s candidate in History of Design and Curatorial Studies at Parsons, The New School/Cooper Hewitt, Smithsonian Design Museum, where she was also the 2017-2018 Curatorial Fellow in Textiles.',
    'Lead Curator / Design Historian'
),
(
    '9RjAd8EmBr@c-a-r-i.org',
    'evan.collins',
    '',
    0,
    now(),
    now(),
    now(),
    'Evan',
    'Collins',
    'Evan Collins is an architect and design archivist based in Hollywood, California. His early research into the ''Y2K Aesthetic'' beginning in 2014 helped to lay the foundation for the many branching eras studied by CARI; he brings expertise particularly in the fields of graphic, industrial, and interior design of the 1990s. He holds a Bachelors in Architecture from Cal Poly San Luis Obispo and a Masters in Architecture from Columbia University.',
    'Lead Curator / Architecture'
),
(
    'lxiOea0o8w@c-a-r-i.org',
    'max.krieger',
    '',
    0,
    now(),
    now(),
    now(),
    'Max',
    'Krieger',
    'Max Krieger is an independent video game developer based in Cleveland, Ohio, who has been involved with the CARI project since late 2017. With experience in VR, AR, and traditional video game development, Max has focused on revisiting design conventions of both game mechanics and UI, approaching them from experimental perspectives informed and inspired by various aesthetics under CARI''s umbrella of study. Presently, Max is working on CROSSNIQ+, a y2k-inspired arcade puzzle game coming to Nintendo Switch and computer platforms in 2019.',
    'Assistant Curator / Interactive Media'
),
(
    'aOKexhAPSO@c-a-r-i.org',
    'zovi.mcentee',
    '',
    0,
    now(),
    now(),
    now(),
    'Zovi',
    'McEntee',
    'Zovi McEntee is an experimental musician, writer, graphic designer, InDesign specialist, and web/JavaScript developer from the New York City area. She holds a Bachelors of Science in Electronic Media, Arts, and Communication from Rensselaer Polytechnic Institute. She has been involved with the CARI project since 2016.',
    'Webmaster / Project Manager'
),
(
    'UW7YcanWnY@c-a-r-i.org',
    'alex.edwards',
    '',
    0,
    now(),
    now(),
    now(),
    'Alex',
    'Edwards',
    'Alex is a designer, video artist and photographer who lives in Sheffield, UK. They are a graduate of Sheffield Hallam University, with a Bachelors in Photography. They have been involved with CARI since mid 2018.',
    'Community Organizer / Curator'
),
(
    'bYtMUeqPXW@c-a-r-i.org',
    'jack.grimes',
    '',
    0,
    now(),
    now(),
    now(),
    'Jack',
    'Grimes',
    'Jack Grimes is a graphic designer and researcher currently based in North Carolina who''s worked for clients from DESKPOP to Warner Music. With a focus on exploring narrative and object by blending physical and digital media, Jack''s work calls on influences and processes from a wide range of subcultures and aesthetic movements. Jack is currently pursuing a BFA in graphic design at Appalachian State University. His portfolio can be found at <a href="https://www.jackapedia.design/" target="_blank noopener noreferrer">jackapedia.design</a>.',
    'Designer / Curator'
),
(
    'PVaE3mWNhc@c-a-r-i.org',
    'chan.miller',
    '',
    0,
    now(),
    now(),
    now(),
    'Chan',
    'Miller',
    'Chan Miller is a software engineer and musician based in Atlanta, Georgia. He holds a Bachelor of Science in Computer Science from the Georgia Institute of Technology. When not writing code, Chan plays drums for an indie band called <a href="https://open.spotify.com/artist/4wlyzfgVJHCbF3LXiQAjCm" target="_blank noopener noreferrer">Dinner Time</a>. He has been involved with the CARI project since 2020.',
    'Web Developer'
);

insert into tb_entity_role (
    entity,
    role
)
select entity,
       1
  from tb_entity;
