if (keyboard_check_pressed(ord("E")))
{
	MenuObject.canInteract = true
	//PlayerObject.canWalk = true
	//PlayerObject.menuOpen = false
	//instance_destroy(MenuObject)
	instance_destroy(self)
	instance_destroy(id)
}

if (keyboard_check_pressed(vk_enter))
{
	switch (selectedIndex)
	{
		case 0:
			menu.summaryMode = true
			menu.canInteract = true
			instance_destroy(id)
			break
		case 1:
		    menu.switchIndex = menu.selectedIndex
			menu.switchMode = true
			menu.canInteract = true
			instance_destroy(id)
			break
		case 2:
			if (CanEvolve(global.playerParty, menu.selectedIndex) != "")
			{
				var pkmnInfo = ds_list_find_value(global.playerParty, menu.selectedIndex)

				var player = instance_find(PlayerObject, 0)
				var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			
				ds_list_add(dialogue.textList, string_concat("Your ", GetName(pkmnInfo), " evolved into a ", CanEvolve(global.playerParty, menu.selectedIndex)))
			
				player.talking = true
			
				var evolutionDexNumber = GetNumberByName(CanEvolve(global.playerParty, menu.selectedIndex))
				ds_list_replace(pkmnInfo, 4, GetSpriteByNumber(evolutionDexNumber))
				ds_list_replace(pkmnInfo, 1, CanEvolve(global.playerParty, menu.selectedIndex))
				ds_list_replace(pkmnInfo, 0, evolutionDexNumber)
			
				ds_list_add(global.pokedex, GetNameByNumber(evolutionDexNumber))
			
				menu.menu.player.menuOpen = false
				instance_destroy(menu.menu)
				instance_destroy(menu)
				instance_destroy(id)
			}
			break
	}
}

if (keyboard_check_pressed(ord("W"))) selectedIndex--
if (keyboard_check_pressed(ord("S"))) selectedIndex++

if (keyboard_check_pressed(vk_up)) selectedIndex--
if (keyboard_check_pressed(vk_down)) selectedIndex++

if (selectedIndex == ds_list_size(optionList)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(optionList)-1
