create table tb_message_template (
    message_template integer primary key not null,
    ext_id           text not null unique
);

insert into tb_message_template (
    message_template,
    ext_id
) values (
    1,
    'd-2dc30f75099544479e86c1057e2b520a'
), (
    2,
    'd-2e9ac445cdce460b83e5abf119fed2d7'
), (
    3,
    'd-8edb5b755fd04d4092c366fe24452ad9'
);