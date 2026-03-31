// Collision with PlayerObject
if (!talking)
{
    talking = true;
    
    var dialogue = instance_create_depth(x, 500, -9999999999999, TextboxObject);

    ds_list_add(dialogue.textList, "Yo Gash!");
    ds_list_add(dialogue.iconList, MaryFaceSprite);
	
	dialogue.ui_off_x = 0;
	dialogue.ui_off_y = 300; 
	
	TextboxObject.scalePerc = 100; 
	
	PlayerObject.talking = true; 

}
	
	
	
	
	