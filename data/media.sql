insert into tb_media_creator ( name )
     values ( 'John Sayles' ),
            ( 'Global Village Communication' ),
            ( 'Rafael' );

insert into tb_media
(
    url,
    preview_image_url,
    label,
    description,
    media_creator,
    year
)
values
(
	'https://d2w9rnfcy7mm78.cloudfront.net/1986528/display_21c33e6e30c0413b18712d4874361055.jpg?1522724866?bc=1',
	'https://d2w9rnfcy7mm78.cloudfront.net/1986528/square_21c33e6e30c0413b18712d4874361055.jpg?1522724866?bc=1',
	'Test image 1',
	'This is a test image',
    1,
	1987
),
(
	'https://d2w9rnfcy7mm78.cloudfront.net/1986562/display_887ec03b4f30662497c53f3785604258.png?1522724961?bc=1',
	'https://d2w9rnfcy7mm78.cloudfront.net/1986562/square_887ec03b4f30662497c53f3785604258.png?1522724961?bc=1',
	'Test image 2',
	'This is a test image',
    2,
	1993
),
(
	'https://d2w9rnfcy7mm78.cloudfront.net/1986563/display_3223e1bccace4623bf407f33b8298606.png?1522724962?bc=1',
	'https://d2w9rnfcy7mm78.cloudfront.net/1986563/square_3223e1bccace4623bf407f33b8298606.png?1522724962?bc=1',
	'Test image 3',
	'This is a test image',
    3,
	1993
),
(
	'https://d2w9rnfcy7mm78.cloudfront.net/1986564/display_bd04d24b727edfe2110f050a744d412e.png?1522724963?bc=1',
	'https://d2w9rnfcy7mm78.cloudfront.net/1986564/square_bd04d24b727edfe2110f050a744d412e.png?1522724963?bc=1',
	'Test image 4',
	'This is a test image',
	null,
	1990
),
(
	'https://d2w9rnfcy7mm78.cloudfront.net/1986565/display_e4d745c595b4cda4c33cff1c44ecea3e.png?1522724977?bc=1',
	'https://d2w9rnfcy7mm78.cloudfront.net/1986565/square_e4d745c595b4cda4c33cff1c44ecea3e.png?1522724977?bc=1',
	'Test image 5',
	'This is a test image',
	null,
	1997
);

insert into tb_aesthetic_media ( aesthetic, media )
     values ( 1, 1 ),
            ( 1, 2 ),
            ( 1, 3 ),
            ( 1, 4 ),
            ( 1, 5 );