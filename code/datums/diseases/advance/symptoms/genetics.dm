/*
//////////////////////////////////////

DNA Saboteur

	Very noticable.
	Lowers resistance tremendously.
	No changes to stage speed.
	Decreases transmittablity tremendously.
	Fatal Level.

Bonus
	Cleans the DNA of a person and then randomly gives them a trait.

//////////////////////////////////////
*/

/datum/symptom/genetic_mutation
	name = "Deoxyribonucleic Acid Saboteur"
	desc = "The virus bonds with the DNA of the host, causing damaging mutations until removed."
	stealth = -2
	resistance = -3
	stage_speed = 0
	transmittable = -3
	level = 6
	severity = 4
	var/list/possible_mutations
	var/archived_dna = null
	base_message_chance = 50
	symptom_delay_min = 60
	symptom_delay_max = 120
	var/no_reset = FALSE
	threshold_desc = "<b>Resistance 8:</b> Causes two harmful mutations at once.<br>\
					  <b>Stage Speed 10:</b> Increases mutation frequency.<br>\
					  <b>Stealth 5:</b> The mutations persist even if the virus is cured."

/datum/symptom/genetic_mutation/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/C = A.affected_mob
	if(!C.has_dna())
		return
	switch(A.stage)
		if(4, 5)
			to_chat(C, "<span class='warning'>[pick("Your skin feels itchy.", "You feel light headed.")]</span>")
			C.dna.remove_mutation_group(possible_mutations)
			for(var/i in 1 to power)
				C.randmut(possible_mutations)

// Archive their DNA before they were infected.
/datum/symptom/genetic_mutation/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stealth"] >= 5) //don't restore dna after curing
		no_reset = TRUE
	if(A.properties["stage_rate"] >= 10) //mutate more often
		symptom_delay_min = 20
		symptom_delay_max = 60
	if(A.properties["resistance"] >= 8) //mutate twice
		power = 2
	possible_mutations = (GLOB.bad_mutations | GLOB.not_good_mutations) - GLOB.all_mutations[RACEMUT]
	var/mob/living/carbon/M = A.affected_mob
	if(M)
		if(!M.has_dna())
			return
		archived_dna = M.dna.mutation_index

// Give them back their old DNA when cured.
/datum/symptom/genetic_mutation/End(datum/disease/advance/A)
	if(!..())
		return
	if(!no_reset)
		var/mob/living/carbon/M = A.affected_mob
		if(M && archived_dna)
			if(!M.has_dna())
				return
			M.dna.mutation_index = archived_dna
			M.domutcheck()



/*
//////////////////////////////////////

Transcendence

	Somewhat Noticeable.
	Improves resistence considerably..
	Improves stage speed somewhat.
	Harms transference.
	Intense Level.
	Moderate Severity. (HANDLE WITH CARE)

Bonus
	Genetic effects are enhanced in ways may or may not be generally beneficial.
		HULK: Nanomachines, son. Becomes somewhat bulletproof.
		XRAY: Emits light from the eyes and increases view range by 1.
		COLDRES: You're hot forever.
		CHAMELEON: You can move a bit more without disturbing the invisibility.
		ESP: Your head hurts now, but you're more powerful.
		BLIND: You are now Daredevil.
		MONKEY: You become able to speak English again.

TODO
	Find a way to offload all M.transtatus to a local transtatus var without generating a ton of unnessecary extra calls or breaking the game.
//////////////////////////////////////
*/


/mob/living/carbon/var/transtatus = 0

/datum/symptom/transcend

	name = "Deoxyribonucleic Acid Despooling"
	stealth = -2
	resistance = 3
	stage_speed = 20 //temp
	transmittable = -1
	level = 6
	severity = 2

/datum/symptom/transcend/Activate(var/datum/disease/advance/A)
	if(!..())
		return
	if(prob(20))
		src.evolve(A)
	return

/datum/symptom/transcend/Start(var/datum/disease/advance/A)
	evolve(A)
	return

/datum/symptom/transcend/End(var/datum/disease/advance/A)
	devolve(A)
	return

/datum/symptom/transcend/proc/evolve(var/datum/disease/advance/A)
	var/mob/living/carbon/M = A.affected_mob
	M.bounce(HULKED,M.dna.check_mutation(HULK),"Your muscles have transcended the limits of human strength. Little remains of what they once were.","Your muscles shrivel horribly.")
	M.bounce(XRAYED,M.dna.check_mutation(XRAY),"Your eyes begin to radiate light like miniature suns and what is revealed by the glow is dazzling.","Your world goes dark.")
	M.bounce(WARMED,M.dna.check_mutation(SPACEMUT),"The unending warmth intensifies and you suddenly don't feel so cozy anymore.","You stop sweating.")
	M.bounce(CAMOED,M.dna.check_mutation(CHAMELEON),"Even you aren't sure where you are anymore.","You feel centered again.")
	M.bounce(ESPERED,M.dna.check_mutation(TK),"You feel incredibly powerful! The brain was not made for such feats.","Your mind feels normal.")
	M.bounce(BLINDED,M.dna.check_mutation(BLINDMUT),"You have never seen so clearly as you do now.","You lose your superhuman perception.")
	M.bounce(MONKEYED,M.dna.check_mutation(RACEMUT),"You regain some of your faculties, defying your primate nature.","You become a normal monkey again.")

/datum/symptom/transcend/proc/devolve(var/datum/disease/advance/A)
	var/mob/living/carbon/M = A.affected_mob
	M.wipebounce(HULKED,0,"Your muscles shrivel horribly.")
	M.wipebounce(XRAYED,0,"Your world goes dark.")
	M.wipebounce(WARMED,0,"You stop sweating.")
	M.wipebounce(CAMOED,0,"You feel centered again.")
	M.wipebounce(ESPERED,0,"Your mind feels normal.")
	M.wipebounce(BLINDED,0,"You lose your superhuman perception.")
	M.wipebounce(MONKEYED,0,"You become normal monkey again.")
	M.transtatus = 0


/mob/living/carbon/proc/transcendgene(var/tran)
	transtatus |= tran
/mob/living/carbon/proc/normalizegene(var/tran)
	transtatus &= ~tran
/mob/living/carbon/proc/Transcend_test(var/tran)
	if(transtatus & tran) return 1
	else return 0
/mob/living/carbon/proc/bounce(var/dependent,var/test,var/truestring,var/falsestring)
	if(test)
		if(!(transtatus & dependent))
			transcendgene(dependent)
			src << "<span class='notice'>[truestring]</span>"
	else
		if(transtatus & dependent)
			normalizegene(dependent)
			src << "<span class='notice'>[falsestring]</span>"

/mob/living/carbon/proc/wipebounce(var/dependent,var/targetstatus, var/string) //targetstatus is a binary operator
	if((transtatus & dependent) & !(targetstatus & dependent)) src << "<span class='notice'>[string]</span>"
	targetstatus ? transcendgene(dependent) : normalizegene(dependent)