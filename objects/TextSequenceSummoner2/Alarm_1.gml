// If this object is controlled by a sequence, pause that sequence
	var seq_element_id = -1;

//	if (in_sequence && !is_undefined(sequence_instance)) {
//	    seq_element_id = sequence_instance.elementID;
//	    layer_sequence_pause(seq_element_id);
//	}

//Create textbox
	var dialogue = instance_create_depth(x,500,-9999999999999,TextboxObject_GINKGO_DIALOGUE)
	
	dialogue.ui_off_x = 0;
	dialogue.ui_off_y = 300; 
	
	TextboxObject_GINKGO_DIALOGUE.scalePerc = 10; 

	ds_list_add(dialogue.textList, 
	"I came to this island region to study the strange and, frankly, otherworldly Pokémon that live here. ",
	"Most trainers tend to stay away from this region because it’s considered too dangerous.",
	"But where others see certain death, I see opportunity!",
	"There must be some secret to this region – why are its Pokémon so different than those seen elsewhere? ",
	"Perhaps you can help me chronicle this mysterious region of the Pokémon World with your POKEDEX!",
	"Oh, and, uh, you can also catch Pokémon with your POKEBALLS and all that. ",
	"I mean, frankly, I wouldn’t.",
	"But hey, as long as you’re doing it, it might help us get to the bottom of this! ",
	"Well! STOP by my lab when you’re ready to choose your first Pokémon and begin your journey!")

// Pass the sequence id to the textbox so it can resume later
	dialogue.seq_element_id = seq_element_id;