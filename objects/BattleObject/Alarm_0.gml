var dialogue = instance_create_layer(x,y,"UIElements",BattleTextboxObject)
dialogue.textList = textList
if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)

/*
if room == RoomBattleGodzilla {
	cloud_level = 1;
	fx = layer_get_fx("Clouds");
	    if (fx != -1) {
        fx_set_parameter(fx, "g_CloudLevel", cloud_level);
    }
	
	layer_set_visible("Clouds", true);
}

