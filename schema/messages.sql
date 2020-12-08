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
), (
    2,
    'Reset Your CARI Password',
$_$
Hello ${username},

You are receiving this email because a request to reset your password has been made. If you did not request this, please ignore this message. Otherwise, please navigate to the link below to reset your password:
${resetPasswordUrl}

This link is valid for one hour.

Thank you,
the Consumer Aesthetics Research Institute
$_$,
$_$
<p>Hello ${username},</p>

<p>
    You are receiving this email because a request to reset your password has been made.
    If you did not request this, please ignore this message.
    Otherwise, please click the link below to reset your password:
</p>
<p>
    <a href="${resetPasswordUrl}">${resetPasswordUrl}</a>
</p>
<p>This link is valid for one hour.</p>
<p>
    Thank you,
    <br />
    - the Consumer Aesthetics Research Institute
</p>
$_$,
    'd-2e9ac445cdce460b83e5abf119fed2d7'
);

update tb_message_template
   set body_plaintext = regexp_replace( body_plaintext, '(^[\n\r])|([\n\r]$)', '', 'g' ),
       body_html      = regexp_replace( body_html,      '(^[\n\r])|([\n\r]$)', '', 'g' );