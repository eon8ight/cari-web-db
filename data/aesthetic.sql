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
            ( 1, 3, 'Shared concepts/appropriation/motifs' ),
            ( 2, 1, 'Predecessor' ),
            ( 3, 1, 'Shared concepts/appropriation/motifs' );