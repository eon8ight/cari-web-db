create table tb_message_template (
    message_template integer primary key not null,
    subject          text not null,
    body_plaintext   text not null,
    body_html        text not null,
    ext_id           text not null unique
);

insert into tb_message_template (
    message_template,
    subject,
    body_plaintext,
    body_html,
    ext_id
) values (
    1,
    'Confirm Your CARI account',
$_$
Hello ${username},

Please navigate to the link below to confirm your CARI account.
${confirmUrl}

Thank you,
the Consumer Aesthetics Research Institute
$_$,
$_$
<p>Hello {{username}},</p>
<p>Please click the link below to confirm your CARI account.</p>
<p>
    <a href="{{confirmUrl}}">{{confirmUrl}}</a>
</p>
<p>
    Thank you,
    <br />
    - the Consumer Aesthetics Research Institute
</p>
$_$,
    'd-2dc30f75099544479e86c1057e2b520a'
);