/*
//////////////////////////////////////
Anti Vitiligo
        Extremely Noticable.
        Decreases resistance slightly.
        Reduces stage speed slightly.
        Reduces transmission.
        Critical Level.
BONUS
        wachu lookin at nygga
//////////////////////////////////////
*/

/datum/symptom/antivitiligo

        name = "Anti-Vitiligo"
        stealth = -3
        resistance = -1
        stage_speed = -1
        transmittable = -3
        level = 3
        severity = 3
        var/nigged

/datum/symptom/antivitiligo/Activate(var/datum/disease/advance/A)
        ..()
        if(prob(5))
                var/mob/living/M = A.affected_mob
                if(istype(M, /mob/living/carbon/human))
                        var/mob/living/carbon/human/H = M
                        if(H.skin_tone == "african1")
                                return
                        switch(A.stage)
                                if(5)
                                        if(!nigged)
                                                nigged = !nigged
                                                H.skin_tone = "african1"
                                                H.hair_style = "Afro"
                                                var/random_name = ""
                                                switch(H.gender)
                                                        if(MALE)
                                                                random_name = pick("Jamal", "Devon", "Ooga", "Rayquan", "Jayden", "Elijah", "Xavier", "Antwan", "Walka", "Kunta")
                                                        else
                                                                random_name = pick("Shaniqua", "Jewel", "Latifa", "Lashanda", "Diamond", "Isis", "Imani", "Nevaeh")
                                                random_name += " [pick("Melons", "Jabongo", "Smollett", "Smith", "Black", "Williams", "Washington", "Young", "Wright", "Wiggins", "Sims", "Kinte")]"
                                                H.SetSpecialVoice(random_name)
                                                M.visible_message("<span class='danger'>[M] says shieeeet and begins clawing at their face!</span>")
                                else
                                        H.visible_message("<span class='warning'>[H] looks a bit darker than usual.</span>", "<span class='notice'>You suddenly crave fried chicken.</span>")
        return