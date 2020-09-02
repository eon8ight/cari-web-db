insert into tb_aesthetic
(
    name,
    url_slug,
    symbol,
    start_year,
    end_year,
    description
)
values
(
    'Global Village Coffeehouse',
    'global-village-coffeehouse',
    'Gv',
    1985,
    1995,
$_$A network of aesthetics emerging in the late 1980s, some an evolution of prog-punk-zolo memphis-y squiggles, keith haring, woodcut revival, a "return-to-the-natural" handrawing movement, reaction against the computer aided design boom, late 80s environmentalism revival, etc. Still very postmodern in the sense of appropriating seemingly endless prior artistic movements, mainly for commercial/corporate purposes. Peaks in the mid 1990s, falling out of favor later on as the pendulum swung back to the minimalism/tech/clean vibes of <a href="/aesthetic/y2k">Y2K</a> & <a href="/aesthetic/gen-x-soft-club">Gen X/YAC</a>. It's very wide-ranging and could be split into many sub-groups, but this format seems to work better. Common motifs include: woodcuts, "tribal/ancient imagery and iconography", moons, suns, spirals, hands, eyes, stars, simple styled flowing/curvy figures, "aroma swirls", coffee cups, natural elements like trees/waves/landscapes, earth tones, hand-drawn look, "airbrushed dirty look", the earth/globe, hearts, colorful gradated backgrounds, rough irregular borders & lines. Overlaps with "pop surrealism" from the same time period, though GVC is usually trying to convey "sincerity" as much it is needed to sell something; sorta faux-naive, down to earth, warm.$_$
),
(
    'Mission School Post-GVC',
    'mission-school-post-gvc',
    'Ms',
    1995,
    null,
    ''
),
(
    'Boho Chic',
    'boho-chic',
    'Bc',
    2012,
    null,
    ''
);

insert into tb_aesthetic_relationship ( from_aesthetic, to_aesthetic, description )
     values ( 1, 2, 'Successor' ),
            ( 1, 3, 'Shared concepts/appropriation/motifs' );


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
    creator,
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
