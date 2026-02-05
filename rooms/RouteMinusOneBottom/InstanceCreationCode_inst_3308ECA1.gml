lineSight = 120 //The range they can see players
lineSightDir = "Down" //Should be Up, Down, Left or Right

walkDownSprite = KcoKtWalkDownSprite;


ds_list_add(textList, "Hi, I'm a trainer from Kanto!","No way!! Are you KcoKt?! I've read all about your adventures!","Really? Wow, Thanks! I must say, you guys live in a strange region...","These Pokémon are weird, but I will absolutely demolish you with them!!!")
ds_list_add(nameList, "KcoKt","Mary", "KcoKt", "KcoKt")
ds_list_add(iconList, KcoKtIdleSprite,MaryWalkDownSprite,KcoKtIdleSprite,KcoKtIdleSprite)

ds_list_add(postBattleTextList, "Nice meeting you both!","I think you're well on your way to become the next POKÉMON LEGENDS...!")