// Instance-only setup: shared MorlockTrainer events and other instances stay unchanged.
name = "Morlock Tunnel Scout"
battleFlag = "MorlockCity3_inst_6D3A9101"
lineSightDir = "Right"
lineSight = 400

// Replace the shared object's greeting after its Create event has run.
ds_list_clear(textList)
ds_list_clear(nameList)
ds_list_clear(iconList)
if HasFlag("Potion") {
	ds_list_add(textList, "Hey buddy, I'm practicing with my Pokémon so I can become the Pokémon Master!! Wanna spar?")
	ds_list_add(nameList, "Morlock trainer")
	ds_list_add(iconList, sprite_index)
	
	ds_list_add(postBattleTextList, "Dang! I really gotta practice harder.","Thanks for the match!")
	ds_list_add(postBattleIconList,sprite_index,sprite_index)
	ds_list_add(postBattleNameList, "Morlock trainer", "Morlock trainer")
}
else if (HasFlag("Potion") == false) or (HasFlag("PotionCure") == true) {

	ds_list_add(textList, "Ack!! A Human!!")
	ds_list_add(nameList, "Morlock trainer")
	ds_list_add(iconList, sprite_index)

	ds_list_add(postBattleTextList, "Beaten by a human!! How humiliating.","Hey, let's keep this between us & I won't eat you. Deal?")
	ds_list_add(postBattleIconList,sprite_index,sprite_index)
	ds_list_add(postBattleNameList, "Morlock trainer", "Morlock trainer")
	}
// NPCParent's first alarm builds this instance's team from its unique name.


