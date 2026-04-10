player = noone
active = true
selectedIndex = 0

optionsList = ds_list_create()

if (ds_list_size(global.playerParty) > 0)
{
	ds_list_add(optionsList, "Pokedex", "Pokemon")
}
ds_list_add(optionsList, "Bag")
if (ds_list_size(global.playerParty) > 0)
{
	ds_list_add(optionsList, "PC")
}
ds_list_add(optionsList, "Settings", "Save Game", "Load Game", "Exit")