/datum/reagent/medicine/healthpot
	name = "Health Potion"
	description = "Gradually regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff0000"
	taste_description = "health"
	overdose_threshold = 0
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 210

/datum/reagent/medicine/healthpot/on_mob_life(mob/living/carbon/M)
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+50, BLOOD_VOLUME_MAXIMUM)
	else
		//can overfill you with blood, but at a slower rate
		M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)	
		//some peeps dislike the church, this allows an alternative thats not a doctor or sleep. 
		M.heal_wounds(2) //at a motabalism of .5 U a tick this translates to 80WHP healing with 20 U Most wounds are unsewn 15-100. This is powerful on single wounds but rapidly weakens at multi wounds.
		M.update_damage_overlays()
	M.adjustBruteLoss(-1*REM, 0) // 45u = 15 oz = 120~ points of healing
	M.adjustFireLoss(-1*REM, 0)
	M.adjustOxyLoss(-1, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1*REM)
	M.adjustCloneLoss(-1*REM, 0)
	..()
	. = 1
//super and minor health potions
/datum/reagent/medicine/lesserhealthpot
	name = "Lesser Health Potion"
	description = "Gradually minorly all types of damage."
	reagent_state = LIQUID
	color = "#ff6b6b"
	taste_description = "cold oil and flesh"
	overdose_threshold = 0
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 210

/datum/reagent/medicine/lesserhealthpot/on_mob_life(mob/living/carbon/M)
	M.heal_wounds(1) 
	M.update_damage_overlays()
	M.adjustBruteLoss(-0.4*REM, 0) // 45u = 15 oz = 50 points of healing
	M.adjustFireLoss(-0.4*REM, 0)
	M.adjustOxyLoss(-0.5, 0)
	M.adjustCloneLoss(-0.5*REM, 0) //heals as half as health
	..()
	. = 1

	
/datum/reagent/medicine/greaterhealthpot
	name = "Greater Health Potion"
	description = "Greatly heals all types of damage."
	reagent_state = LIQUID
	color = "#ff7700"
	taste_description = "orange"
	overdose_threshold = 47 //45 units in a bottle, 2 units to safeguard
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 210

/datum/reagent/medicine/greaterhealthpot/on_mob_life(mob/living/carbon/M)
	var/list/wCount = M.get_wounds()
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+50, BLOOD_VOLUME_MAXIMUM)
	else
		M.blood_volume = min(M.blood_volume+10, BLOOD_VOLUME_MAXIMUM)
	if(wCount.len > 0)	
		M.heal_wounds(4)
		M.update_damage_overlays()
	M.adjustBruteLoss(-2*REM, 0) // 45u = 15 oz = 240 points of healing
	M.adjustFireLoss(-2*REM, 0)
	M.adjustOxyLoss(-2, 0)
	M.adjustCloneLoss(-2*REM, 0) //heals as twice as much as health + every organ
	M.adjustOrganLoss(ORGAN_SLOT_LUNGS, -1)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, -1)
	M.adjustOrganLoss(ORGAN_SLOT_TONGUE, -1)
	M.adjustOrganLoss(ORGAN_SLOT_EARS, -1)
	M.adjustOrganLoss(ORGAN_SLOT_EYES, -1)
	M.adjustOrganLoss(ORGAN_SLOT_LIVER, -1)
	M.adjustOrganLoss(ORGAN_SLOT_APPENDIX, -1)
	M.adjustOrganLoss(ORGAN_SLOT_STOMACH, -1)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1)
	..()
	. = 1

/datum/reagent/medicine/greaterhealthpot/overdose_process(mob/living/carbon/M)
	M.adjustBruteLoss(1, 0)
	M.adjustToxLoss(3, 0)
	M.add_nausea(15)
	M.adjustFireLoss(1, 0)


//lesser and greater mana potions
/datum/reagent/medicine/lessermanapot
	name = "Lesser Mana Potion"
	description = "Gradually regenerates stamina."
	reagent_state = LIQUID
	color = "#00e1ff"
	taste_description = "cold oil and fish"
	overdose_threshold = 0
	metabolization_rate = 20 * REAGENTS_METABOLISM
	alpha = 220

/datum/reagent/medicine/lessermanapot/on_mob_life(mob/living/carbon/M)
	M.energy_add(100)
	..()
	. = 1

/datum/reagent/medicine/manapot
	name = "Mana Potion"
	description = "Gradually regenerates stamina and removes tiredness."
	reagent_state = LIQUID
	color = "#0077ff"
	taste_description = "manna"
	overdose_threshold = 0
	metabolization_rate = 20 * REAGENTS_METABOLISM
	alpha = 220

/datum/reagent/medicine/manapot/on_mob_life(mob/living/carbon/M)
	M.energy_add(200)
	..()
	. = 1
	if(M.has_status_effect(/datum/status_effect/debuff/sleepytime))
		M.remove_status_effect(/datum/status_effect/debuff/sleepytime)
		M.remove_stress(/datum/stressevent/sleepytime)

/datum/reagent/medicine/greatermanapot
	name = "Greater Mana Potion"
	description = "Gradually regenerates stamina and removes tiredness."
	reagent_state = LIQUID
	color = "#4c00ffe3"
	taste_description = "pure manna"
	overdose_threshold = 0 //effectively a energy drink, no reason to add a overdose unlike health
	metabolization_rate = 20 * REAGENTS_METABOLISM
	alpha = 210

/datum/reagent/medicine/greatermanapot/on_mob_life(mob/living/carbon/M)
	M.energy_add(400)
	..()
	. = 1
	if(M.has_status_effect(/datum/status_effect/debuff/sleepytime))
		M.remove_status_effect(/datum/status_effect/debuff/sleepytime)
		M.remove_stress(/datum/stressevent/sleepytime)
		M.Sleeping(-40)
		M.apply_status_effect(/datum/status_effect/buff/greatermanabuff)

/datum/reagent/berrypoison
	name = "Berry Poison"
	description = "Contains a poisonous thick, dark purple liquid."
	reagent_state = LIQUID
	color = "#00ffdd"  //more cyan/greenish to differ from mana
	metabolization_rate = 0.1

/datum/reagent/berrypoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()

/datum/reagent/organpoison
	name = "Organ Poison"
	description = "A viscous black liquid clings to the glass."
	reagent_state = LIQUID
	color = "#ff2f00"
	metabolization_rate = 0.1

/datum/reagent/organpoison/on_mob_life(mob/living/carbon/M)
	if(HAS_TRAIT(M, TRAIT_NASTY_EATER) || HAS_TRAIT(M, TRAIT_ORGAN_EATER) || HAS_TRAIT(M, TRAIT_WILD_EATER))
		return ..()
	else
		M.add_nausea(9)
		M.adjustToxLoss(3, 0)
	return ..()

/datum/reagent/erpjuice/cum
	name = "Erotic Fluid"
	description = "A thick, sticky, cream like fluid. produced during an orgasm."
	reagent_state = LIQUID
	color = "#ebebeb"
	taste_description = "salty and tangy"
	metabolization_rate = 0.1

/datum/reagent/erpjuice/cum/on_mob_life(mob/living/carbon/M) //Rejoice, cum whores can now very inefficiently drink cum to substain themselves.
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			H.adjust_hydration(1)
			H.adjust_nutrition(0.5) //Semen is not very nutritious. The player can go about 3 rounds of cumming before needing to wait a long time code-wise to cum more.
		if(H.blood_volume < BLOOD_VOLUME_NORMAL)
			H.blood_volume = min(H.blood_volume+10, BLOOD_VOLUME_NORMAL)
	..()

/datum/crafting_recipe/roguetown/cooking/soap
	name = "soap"
	reqs = list(
		/obj/item/ash = 1,
		/datum/reagent/water = 10,
		/obj/item/reagent_containers/food/snacks/fat = 1)
	result = /obj/item/soap
	skill_level = 5
