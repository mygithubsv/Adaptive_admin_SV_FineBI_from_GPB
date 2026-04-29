--// SPDX-License-Identifier: Unlicense
CREATE OR REPLACE FUNCTION public.zfx_get_env_param(in_param text DEFAULT 'env_name'::text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
declare
    env text default 'PARAM NOT EXIST';
--   
begin
if in_param = 'env_name'
then   
-- 
select distinct
    case
        when replace(split_part((node_address::jsonb -> 'name')::text,'.',1),'"','') like 'examplet%' then 'TEST'  
        when replace(split_part((node_address::jsonb -> 'name')::text,'.',1),'"','') like 'examplep%' then 'PROD'
        else 'ENV NOT DEFINED'
    end
    as dns_name
from public.fine_bi_cluster_node_dict f
into env;
--
elseif in_param = 'env_url'
then   
-- 
select distinct
    case
        when replace(split_part((node_address::jsonb -> 'name')::text,'.',1),'"','') like 'examplet%' then 'https://you_site.ru'
        when replace(split_part((node_address::jsonb -> 'name')::text,'.',1),'"','') like 'examplep%' then 'https://you_site.ru'
        else 'URL NOT DEFINED'
    end
    as url_name
from public.fine_bi_cluster_node_dict f
into env;
--
end if;
--
return env;
end;
$function$
;
