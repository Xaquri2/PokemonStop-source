// Collision with PlayerObject
if (!talking) && (!HasFlag("MaryTalkShadow")) //(!global.MaryTalkMutant)
{
    talking = true;
	//global.MaryTalkMutant = true;
	ds_list_add(global.flags, "MaryTalkShadow")
    
    var dialogue = instance_create_depth(x, 500, -9999999999999, TextboxObject);

    ds_list_add(dialogue.textList, "I get a bad feeling about this place...","It's like a chill wind blowing past me...");
    ds_list_add(dialogue.iconList, MaryFaceSprite,MaryFaceSprite);
	ds_list_add(dialogue.nameList, "Mary","Mary");
	
	dialogue.ui_off_x = 0;
	//dialogue.ui_off_y = 300; 
	
	TextboxObject.scalePerc = 100; 
	
	PlayerObject.talking = true; 

}
	
	
	
	
	