// Collision with PlayerObject
if (!talking) && (!HasFlag("MaryTalkMorlock"))//(!global.MaryTalkMorlock)
{
    talking = true;
	//global.MaryTalkMorlock = true;
	ds_list_add(global.flags, "MaryTalkMorlock")
    
    var dialogue = instance_create_depth(x, 500, -9999999999999, TextboxObject);

    ds_list_add(dialogue.textList, "Gash... Those are HUMANS in there...",
	"And the Morlocks are gonna... are gonna...","...","Well, maybe we could save them...",
	"They're Pokémon, right? We could just catch them in Pokéballs.");
    ds_list_add(dialogue.iconList, MaryFaceSprite,MaryFaceSprite,MaryFaceSprite,MaryFaceSprite,MaryFaceSprite);
	
	dialogue.ui_off_x = 0;
	//dialogue.ui_off_y = 300; 
	
	TextboxObject.scalePerc = 100; 
	
	PlayerObject.talking = true; 

}
	
	
	
	
	