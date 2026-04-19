// If this object is controlled by a sequence, pause that sequence
	var seq_element_id = -1;

	if (in_sequence && !is_undefined(sequence_instance)) {
	    seq_element_id = sequence_instance.elementID;
	    layer_sequence_pause(seq_element_id);
	}

//Create textbox
	var dialogue = instance_create_depth(x,300,-9999999999999,TextboxObject_GINKGO_DIALOGUE)
	
	// screen-space offsets (pixels, before scalePerc if you want)
		dialogue.ui_off_x = 0;
		dialogue.ui_off_y = 300; 
		dialogue.ui_scale = 1.2; // bigger
	
		dialogue.scalePerc = 10;

	ds_list_add(dialogue.textList, "Ah, you’re awake! s","Good morning, Gash! Better eat a big breakfast – today’s the day! ",
	"You’ve come of age and that means you’re ready to set out on your journey to become a POKEMON TRAINER!",
	"So, just to remind you of some of the basics – well, first of all, you are GASH KETCHUM, cousin of famous Pokémon trainer Ash Ketchum! ",
	"You know, just in case you’d forgotten who you are.",
	"Anyway, I am PROFESSOR GINKGO; I’m a Pokémon researcher here. "
	)

// Pass the sequence id to the textbox so it can resume later
	dialogue.seq_element_id = seq_element_id;
	alarm[2]=50