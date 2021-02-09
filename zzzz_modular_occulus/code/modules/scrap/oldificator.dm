/obj/item/weapon/computer_hardware/hard_drive/portable/design/make_old()
	.=..()
	if(license > 0 && prob(90))
		license = rand(3, (license - 3))

/obj/item/weapon/gun/make_old()
	. = ..()
	if(prob(50))
		fire_delay += rand(0,3)
	if(prob(40))
		recoil_buildup += rand(0,10)
	if(prob(80))
		damage_multiplier = damage_multiplier*(rand(5,10)/10)
	if(prob(60))
		penetration_multiplier = penetration_multiplier*(rand(5,10)/10)
	if(prob(40))
		init_offset += rand(0,10)

/obj/item/weapon/tool/make_old()
	. = ..()
	if(.)
		if(prob(50))
			precision -= rand(0,10)
		if(prob(40))
			workspeed = workspeed*(rand(5,10)/10)
		if(prob(60))
			degradation += rand(0,4)
		if(prob(80))
			health = rand(10, max_health)
