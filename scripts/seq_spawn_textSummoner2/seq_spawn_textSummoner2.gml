function seq_spawn_textSummoner2(){
    instance_create_layer(320, 240, "Instances", TextSequenceSummoner2);
}

function press_enter(){ 
	instance_create_layer(320, 240, "Instances", PressKeyToContinueText_Enter);
}