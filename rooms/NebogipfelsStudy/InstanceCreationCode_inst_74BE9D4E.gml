
if (HasFlag("Potion")) {
	ds_list_add(textList,"Oh! I must say, you look quite good as a Morlock")
	ds_list_add(nameList, "Nebogipfel")
	ds_list_add(iconList, NebogipfelSprite)
}
else {
	if HasItem("Skyview Potion")  //HasFlag("HasNeboPotion") //(HasFlag("ReturnToNebo") and 
	{
		ds_list_add(textList,"Good luck! I hope we meet again!")
		ds_list_add(nameList, "Nebogipfel")
		ds_list_add(iconList, NebogipfelSprite)
	}

	else //if (HasFlag("ReturnToNebo") == false)
	{
		if (HasFlag("ReturnToNebo")) {
			ds_list_add(textList, "Ah, welcome back, Ga-hash! (Wait, is that how you pronounce it? Gyaash? Gosh?)")
			ds_list_add(nameList, "Nebogipfel")
			ds_list_add(iconList, NebogipfelSprite)
		}
		else {
			ds_list_add(textList, "Gah! A Human!!","Erm. I You really are one of them, aren't you?","Yes, I see, fascinating!",
			"I am Nebogipfel.","You needn't fear me; unlike my fellow Morlocks, I have no interest in eating you.","I, uh...","(Resh gliig, what do I say here??)")
			ds_list_add(iconList, sprite_index,  sprite_index,  sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,)
			ds_list_add(nameList, "Morlock","Morlock","Morlock","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel")
		}
	}
}
//else if (HasFlag("ReturnToNebo") and (HasFlag("HasNeboPotion")) == false)
//{
//	if (HasItem("Skyview Mushroom"))
//	{
//		ds_list_add(textList, "Ooh, excellent, this is exciting! What an experiment!",
//		"Okay, here goes!!",
//		"Let’s see… two tablespoons of Glaktar… one goshgash of frashgist..",
//		"Some of my own blood for DNA… Ow! …",
//		"and one Skyglow Mushroom!",
//		"There we go! Your potion! Drink when ready!")
//			
//		ds_list_add(nameList, "Nebogipfel","Nebogipfel","Nebogipfel",
//		"Nebogipfel","Nebogipfel","Nebogipfel")
//		ds_list_add(iconList, NebogipfelSprite,NebogipfelSprite,
//		NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)
//	}
//	else
//	{
//		ds_list_add(dialogue.textList, "Ooh, excellent, this is exciting! What an experiment!",
//		"Oh, one thing though, I just remembered I’m missing an important ingredient: a SKYGLOW MUSHROOM.",
//		"Bring me one of those, and I’ll make the potion for you.")
//			
//		ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel")
//		ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)
//	}
//}
