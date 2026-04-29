--// SPDX-License-Identifier: Unlicense
CREATE TABLE public.z01_rl_dep_dict (
	dpd_p2 text NULL, -- полное название ССП ур.1
	dpd_p2_alias text NULL, -- сокращенное название ССП ур.1
	is_lock_change bool NULL -- признак включения замены
);
COMMENT ON TABLE public.z01_rl_dep_dict IS 'ОМ: роли: справочник сокращений ССП ур.1';
COMMENT ON COLUMN public.z01_rl_dep_dict.dpd_p2 IS 'полное название ССП ур.1';
COMMENT ON COLUMN public.z01_rl_dep_dict.dpd_p2_alias IS 'сокращенное название ССП ур.1';
COMMENT ON COLUMN public.z01_rl_dep_dict.is_lock_change IS 'признак включения замены';

--
