CREATE OR REPLACE FUNCTION fn_get_approximate_end_year(
    pk_aesthetic integer
) RETURNS INTEGER AS
 $_$
       select e.year + es.weight
         from tb_aesthetic a
    left join tb_era e
           on a.end_era = e.era
    left join tb_era_specifier es
           on e.era_specifier = es.era_specifier
        where a.aesthetic = pk_aesthetic
 $_$
LANGUAGE sql;