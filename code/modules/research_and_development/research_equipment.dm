/obj/item/device/analyzer/research
	name = "research analyzer"
	desc = "A handheld device able to gather a wide range of scientific data"
	c_flags = ONBELT

	attack(mob/M, mob/user, def_zone, is_special)
		return

	afterattack(atom/target, mob/user, reach, params)
		. = ..()
		