// TARGET: TAIL
// lightning bolt for tis
ev_run_tis_lightning_check()

// lamp sprite fixes

// TARGET: STRING
spr_atoner>cif_sprite
// TARGET: STRING
spr_atoner_shaken>cif_sprite_shaken

// TARGET: LINENUMBER_REPLACE
// 708
sprite_index = other.cif_sprite_shaken

// TARGET: LINENUMBER_REPLACE
// 627
sprite_index = other.cif_sprite_shaken

// run lightning bolt check for tis statue after it falls into void
// TARGET: LINENUMBER
// 579
ev_run_tis_lightning_check()

// tis statue sprites
// TARGET: LINENUMBER
// 498
else if (b_form == 10) {
	image_speed += 0.25
	sprite_index = spr_ev_tis_statue_shaken
}

// TARGET: LINENUMBER
// 431
else if (b_form == 10)
	sprite_index = spr_ev_tis_statue

// make tis statue have its defining trait
// TARGET: LINENUMBER
// 103
if (b_form != 10)

// TARGET: LINENUMBER
// 102
if (b_form != 10)

