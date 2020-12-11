CREATE OR REPLACE FUNCTION fn_get_approximate_start_year(
    pk_aesthetic integer
) RETURNS INTEGER AS
 $_$
    select case
             when start_year ~ '^\d+$'          then start_year::integer
             when lower(start_year) = 'present' then date_part('year', CURRENT_DATE)::integer
             else regexp_replace((regexp_split_to_array(start_year, '\s+(?=\S*$)'))[2], 's$', '')::integer
                  + (
                      case lower((regexp_split_to_array(start_year, '\s+(?=\S*$)'))[1])
                        when 'very early' then 1
                        when 'early'      then 3
                        when 'mid'        then 5
                        when 'late'       then 7
                        when 'very late'  then 9
                      end
                    )
           end
      from tb_aesthetic
     where aesthetic = pk_aesthetic;
 $_$
LANGUAGE sql;