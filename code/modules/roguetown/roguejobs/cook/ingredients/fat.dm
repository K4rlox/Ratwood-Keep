/*
/obj/item/reagent_containers/food/snacks/butter
	icon = 'icons/roguetown/items/food.dmi'
	name = "butter"
	desc = "A small crock of butter, with a creamy surface."
	icon_state = "butter6"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	foodtype = DAIRY
	slice_path = /obj/item/reagent_containers/food/snacks/butterslice
	slices_num = 6
	slice_batch = FALSE
	bitesize = 6
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/butter/update_icon()
	if(slices_num)
		icon_state = "butter[slices_num]"
	else
		icon_state = "butter_slice"

/obj/item/reagent_containers/food/snacks/butter/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 5
		if(bitecount == 2)
			slices_num = 4
		if(bitecount == 3)
			slices_num = 3
		if(bitecount == 4)
			slices_num = 2
		if(bitecount == 5)
			changefood(slice_path, eater)

/obj/item/reagent_containers/food/snacks/proc/changefood(path, mob/living/eater)
	if(!path || !eater)
		return
	var/turf/T = get_turf(eater)
	if(eater.dropItemToGround(src))
		qdel(src)
	var/obj/item/I = new path(T)
	eater.put_in_active_hand(I)
*/
/obj/item/reagent_containers/food/snacks/butterslice
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "butter_slice"
	name = "butter"
	desc = "A small slice of creamy butter!"
	foodtype = DAIRY
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	slices_num = 0
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/fat
	icon = 'icons/roguetown/items/food.dmi'
	name = "fat"
	desc = "A chunk of rendered animal fat, sustenance and fuel to the living beings."
	icon_state = "fat"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	eat_effect = /datum/status_effect/debuff/uncookedfood
	w_class = WEIGHT_CLASS_TINY
/*
/obj/item/reagent_containers/food/snacks/salo
	name = "salo"
	desc = "A salty piece of fatty salo. Delicious!"
	icon_state = "suet4"
	eat_effect = null
	list_reagents = list(/datum/reagent/consumable/nutriment = 12)
	bitesize = 4
	slice_path = /obj/item/reagent_containers/food/snacks/salo/slice
	slices_num = 4
	slice_batch = FALSE
	rotprocess = null
	w_class = WEIGHT_CLASS_TINY

/obj/item/reagent_containers/food/snacks/salo/update_icon()
	if(slices_num)
		icon_state = "suet[slices_num]"
	else
		icon_state = "suetslice"

/obj/item/reagent_containers/food/snacks/salo/On_Consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 3
		if(bitecount == 2)
			slices_num = 2
		if(bitecount == 3)
			changefood(slice_path, eater)


/obj/item/reagent_containers/food/snacks/salo/slice
	name = "salo"
	desc = "A fatty, salty slice of salo!"
	icon_state = "suetslice"
	eat_effect = null
	slices_num = 0
	bitesize = 2
	slice_path = /obj/item/reagent_containers/food/snacks/salo/slice
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	w_class = WEIGHT_CLASS_TINY
*/
