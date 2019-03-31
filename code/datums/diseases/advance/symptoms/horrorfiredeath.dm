/*
//////////////////////////////////////

asthmosthia

////////////
///DANGER///
////////////

TERROR RUN FLEE GO RUN

//////////////////////////////////////
*/

/datum/symptom/asthmothia

	name = "Asthmothia"
	stealth = -3
	resistance = -5
	stage_speed = -4
	transmittable = -3
	level = 5
	severity = 5

/datum/symptom/asthmothia/Activate(var/datum/disease/advance/A)
	if(!..())
		return
	if(prob(7))
		switch(A.stage)
			if(5)
				if(prob(2))
					A.affected_mob << "<span class='warning'>Your fetid body conjures the unholy lords of Atmospherics! It emits a cloud of smoke and fire so strong that you cannot help but perish through sheer awe! Also, you fucking exploded.</span>"
					A.affected_mob.atmos_spawn_air("plasma=666;TEMP=1000")
					playsound(A.affected_mob.loc, 'sound/effects/Explosion1.ogg', 50, 1)
					A.affected_mob.gib()
				else
					A.affected_mob.emote("cough")
					A.affected_mob << "<span class='warning'>You cough up a plume of Plasma!</span>"
					A.affected_mob.atmos_spawn_air("plasma=[rand(20,30)];TEMP=60")
					A.affected_mob.adjustToxLoss(6)
			else
				A.affected_mob << "<span class='warning'>Your skin is producing a strange purple gas.</span>"
				A.affected_mob.atmos_spawn_air("plasma=[rand(1,5)];TEMP=60")
				A.affected_mob.adjustToxLoss(3)
	return
