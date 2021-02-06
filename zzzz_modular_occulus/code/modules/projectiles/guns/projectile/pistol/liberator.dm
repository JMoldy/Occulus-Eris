/obj/item/weapon/gun/projectile/liberator
	name = ".35 Auto \"Liberator\""
	desc = "The Liberator is a disposable plastic handgun made extremely cheaply. It has a fixed 6 round magazine and is guaranteed to survive 12 standard shots. After that, you're on your own."
	icon = 'zzzz_modular_occulus/icons/obj/guns/projectile/liberator.dmi'
	icon_state = "liberator_0"
	item_state = "liberator"
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 2)
	matter = list(MATERIAL_STEEL = 3, MATERIAL_PLASTIC = 5)
	price_tag = 300
	can_dual = 1
	caliber = CAL_PISTOL
	load_method = SINGLE_CASING
	max_shells = 6
	damage_multiplier = 1
	penetration_multiplier = 0.8
	recoil_buildup = 10
	rarity_value = 6
	init_offset = 2
	var/liferemaining = 0
	var/roundsloaded = 0

/obj/item/weapon/gun/projectile/liberator/Initialize()
	. = ..()
	if(prob(80)) liferemaining = rand(13,15)
	else liferemaining = rand(16,30)
	damage_multiplier = (rand(6,9)/10)
	update_icon()


/obj/item/weapon/gun/projectile/liberator/update_icon()
	..()
	var/iconstring = initial(icon_state)
	if (liferemaining == 0)
		iconstring = "liberator_melt"
	else iconstring = "liberator_[roundsloaded]"
	icon_state = iconstring

/obj/item/weapon/gun/projectile/liberator/handle_post_fire()
	roundsloaded -= 1 //Move me to the IF statement below once the ejection issue is resolved
	if(chambered.BB)
		liferemaining -= 1
		if(chambered.BB.type == /obj/item/projectile/bullet/pistol/hv)
			liferemaining -= 1
			if(prob(12.5))
				to_chat(usr, SPAN_DANGER("You voided the warranty on your cheap-ass plastic gun by loading in high-pressure ammo and it exploded. Idiot."))
				visible_message(SPAN_WARNING("\The [src] blows apart!"))
				qdel(src)
				return
		if(liferemaining == 0)
			update_icon()
			to_chat(usr, SPAN_WARNING("The plastic parts on the [src] melt!"))
			desc += " Melted."
	..()

/obj/item/weapon/gun/projectile/liberator/attack(atom/A, mob/living/user, def_zone) //oh god don't strangle me for how much i copypaste here
	if (A == user && user.targeted_organ == BP_MOUTH && !mouthshoot)
		if(liferemaining == 0)
			to_chat(usr, SPAN_WARNING("The plastic on the [src] has melted!"))
			return
		handle_suicide(user)
	else if(user.a_intent == I_HURT)
		Fire(A, user, pointblank=1)
	else
		return ..()

/obj/item/weapon/gun/projectile/liberator/Fire()
	if(liferemaining == 0)
		to_chat(usr, SPAN_WARNING("The [src] has melted!"))
		return
	. = ..()

/obj/item/weapon/gun/projectile/liberator/load_ammo(obj/item/A, mob/user)

	if(liferemaining == 0)
		to_chat(usr, SPAN_WARNING("The [src] is a molten pile of plastic."))
		return
	if (roundsloaded < max_shells)
		roundsloaded += 1
	. = ..()

/obj/item/weapon/gun/projectile/liberator/unload_ammo(mob/user, var/allow_dump=1)
	if(liferemaining == 0)
		to_chat(usr, SPAN_WARNING("The [src] is a molten pile of plastic."))
		return
	. = ..()
