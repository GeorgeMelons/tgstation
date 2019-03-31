/*
//////////////////////////////////////
Whiteknighting
        Noticable.
        No Resistance.
        Doesn't get the pussy.
        Transmittable.
        Low Level.
BONUS
        Will annoy non-whiteknights, deprivation of fedora causes significant damage that accelerates over time.
//////////////////////////////////////
*/

/datum/symptom/mlady

        name = "Increased Fedora"
        stealth = -2
        resistance = 0
        stage_speed = 0
        transmittable = 3
        level = 2
        severity = 3
        var/intensity = 3

/datum/symptom/mlady/Activate(var/datum/disease/advance/A)
	..()
	if(prob(5 * intensity))
		var/mob/living/carbon/M = A.affected_mob
		switch(A.stage)
			if(1, 2)
				M << "<span notice='notice'>[pick("You suddenly feel like equipping the nearest Fedora.", "For some reason you feel very intent on women's rights.")]</span>"
			if(3, 4)
				if(M.Fedora_test())
					M.visible_message("<span class='danger'>[pick("[M] shouts M'lady!","[M] says M'lady loud enough for the room to hear.")]</span>")
				else
					M.adjustBruteLoss(1)
					M << "<span notice='danger'>[pick("You feel an insurmountable urge to equip the nearest Fedora!", "You feel intense pain thinking of all the helpless ladies in the universe.")]</span>"
			if(5)
				if(M.Fedora_test())
					M.visible_message("<span class='danger'>[pick("[M] shouts a hearty M'lady!","[M] shouts a vigorous M'lady!","[M] shouts an intense M'lady!")]</span>")
				else
					M.adjustBruteLoss(rand(3,5))
					M << "<span notice='danger'>[pick("Your womxn-deprived heart feels like it's going to burst. Where's your Fedora!?","Your head is absolutely pounding. Where's your Fedora!?")]</span>"
		intensity = rand(1,3)
	return

/mob/living/carbon/proc/Fedora_test()
	if(istype(src.head, /obj/item/clothing/head/fedora)) return 1
	else return 0