/obj/machinery/power/Reactor
	name = "Fancy Scientific Generator"
	desc = "It looks like there used to be instructions..."
	icon = 'icons/obj/machines/reactor2.dmi'
	icon_state = "placeholder"
	anchored = 1
	density = 1
	var/active = 0
	var/fuel = 0
	var/maxfuel = 600
	var/genrate = 5000
	var/effmult = 0.6
	var/enrichment = 0
	var/risk = 0
	var/busy = 0

	process()
		if(stat & BROKEN) return
		if(src.active)
			if(src.fuel)
				if(prob(risk))
					visible_message("<span class='danger'>The reactor starts to overload!</span>")
					stat = BROKEN
					flick("reactormelt", src)
					spawn(41)
					visible_message("<span class='danger'>The reactor explodes!</span>")
					explosion(src.loc,0,rand(1,3),rand(2,6),rand(4,8),rand(6,10))
					spawn(21)
					icon_state = "dead"
					return
				add_avail(src.genrate * src.enrichment * src.effmult)
				fuel--
			if(!src.fuel)
				visible_message("<span class='danger'>The reactor runs out of fuel and shuts down!</span>")
				src.active = 0
				busy = 1
				if(icon_state != "placeholder1")
					flick("placeholder2", src) // fuck too tired to write this code night night byond.
				spawn(14)
				updateicon()
				busy = 0

	attack_hand(var/mob/user as mob)
		if(busy) return
		if (!src.fuel) user << "\red There is no fuel in the Reactor!"
		else
			src.active = !src.active
			user << "You switch [src.active ? "on" : "off"] the Reactor."
			if(src.active)// src.overlays += image('power.dmi', "placeholder1")
				busy = 1
				if(icon_state != "placeholder1")
					flick("placeholder2", src) // fuck too tired to write this code night night byond.
				spawn(14)
				updateicon()
				busy = 0
			else if(!src.active)
				busy = 1
				if(icon_state != "placeholder")
					flick("placeholder3", src)
				spawn(14)
				updateicon()
				busy = 0

	attackby(var/obj/item/weapon/nuke_fuel/N as obj, mob/user as mob)
		if(istype(N, /obj/item/weapon/nuke_fuel/deut))
			src.fuel += (src.fuel + 600)
			enrichment = 500
			risk = 0.5
			del N
			return


		/*else if(istype(W, /obj/item/metroid_core))	POWER OUTPUT TESTER, DON'T FUCK WITH THIS
			src.fuel = INFINITY
			enrichment = 300
			risk = 0.01
			del W*/
		else
			..()
			return
		if(src.fuel > src.maxfuel)
			src.fuel = src.maxfuel
			user << "\blue The reactor is now full!"

	proc
		updateicon()
			if(!src.active)
				icon_state = "placeholder"
			if(src.active)
				icon_state = "placeholder1"
