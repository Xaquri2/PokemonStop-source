
if HasFlag("Potion") {
	ds_list_add(textList, "Oh hello, fellow Morlock!",
	"Man, all this study of human culture is making me HUNGRY!",
	"Good thing you're not a human! I would've eaten you right on the spot! Heh, heh, heeee!",
	"Ah, still, I guess I'll have to settle for demolishing your Pokémon!!!")
	ds_list_add(nameList, "Morlock trainer", "Morlock trainer", "Morlock trainer", "Morlock trainer")
	ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index)
	
	ds_list_add(postBattleTextList, "Good match! You win fair and square!",
	"I... should probably go get some dinner.",
	"Till the next time we meet!")
	ds_list_add(postBattleIconList,sprite_index,sprite_index,sprite_index)
	ds_list_add(postBattleNameList, "Morlock trainer", "Morlock trainer", "Morlock trainer")
}
else if (HasFlag("Potion") == false) or (HasFlag("PotionCure") == true) {

	ds_list_add(textList, "I am learning to respect your human culture.",
	"I believe the polite phrasing is, 'may I please eat you?'")
	ds_list_add(nameList, "Morlock trainer", "Morlock trainer", "Morlock trainer")
	ds_list_add(iconList, sprite_index,sprite_index,sprite_index)

	ds_list_add(postBattleTextList, "Ah, then I am NOT to eat you, it seems?",
	"While I strongly disagree with your decision, I respect your resolve in making it.",
	"Still, I hope to eat you the next time we meet!")
	ds_list_add(postBattleIconList,sprite_index,sprite_index,sprite_index)
	ds_list_add(postBattleNameList, "Morlock trainer", "Morlock trainer", "Morlock trainer")
	}

lineSightDir = "Down"
lineSight = 500

name = "BridgeMorlock"