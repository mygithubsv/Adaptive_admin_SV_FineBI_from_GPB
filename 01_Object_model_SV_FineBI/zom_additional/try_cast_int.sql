--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.try_cast_int(p_in text, p_default integer DEFAULT NULL::integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
begin
  begin
    return $1::int;
  exception
    when others then
       return p_default;
  end;
end;
$function$
;