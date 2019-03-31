/*
//////////////////////////////////////
Hotheaditis
        Very Noticable.
        Not very resistant.
        Increases stage speed.
        Not transmittable.
        Medium Level.
TODO
        pending revision, flesh out the train somehow
        more baneposting?
//////////////////////////////////////
*/

/datum/symptom/hothead

        name = "Hothead-itis"
        stealth = -2
        resistance = 1
        stage_speed = 2
        transmittable = 1
        level = 6
        severity = 4

/datum/symptom/hothead/Activate(var/datum/disease/advance/A)
        if(!..())
                return
        if(prob(5))
                var/mob/living/carbon/M = A.affected_mob
                switch(A.stage)
                        if(3, 4, 5)
                                if (M.bodytemperature < 500)
                                        M.bodytemperature = min(450, M.bodytemperature + (50 * TEMPERATURE_DAMAGE_COEFFICIENT))
                        else
                                if (prob(30))
                                        M<< "<span class='notice'>[pick("You feel an intense desire to shitpost on an anonymous imageboard. Also, you're fucking burning hot.")]</span>"
        return