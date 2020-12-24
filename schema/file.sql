create table tb_file_type (
    file_type integer primary key,
    label     varchar(50) not null unique
);

insert into tb_file_type ( file_type, label )
     values ( 1, 'Image' );

create sequence sq_pk_file;

create table tb_file (
    file       integer primary key default nextval( 'sq_pk_file' ),
    file_type  integer not null references tb_file_type,
    url        text not null,
    width      integer,
    height     integer
);