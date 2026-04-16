// Collision with PlayerObject
if (!talking) && (!HasFlag("MaryTalkMutant")) //(!global.MaryTalkMutant)
{
    talking = true;
	//global.MaryTalkMutant = true;
	ds_list_add(global.flags, "MaryTalkMutant")
    
    var dialogue = instance_create_depth(x, 500, -9999999999999, TextboxObject);

    ds_list_add(dialogue.textList, "Whoa... what happened here?","Where are all the people?");
    ds_list_add(dialogue.iconList, MaryFaceSprite,MaryFaceSprite);
	ds_list_add(dialogue.nameList, "Mary","Mary");
	
	dialogue.ui_off_x = 0;
	//dialogue.ui_off_y = 300; 
	
	TextboxObject.scalePerc = 100; 
	
	PlayerObject.talking = true; 

}
	
	
	
	
	