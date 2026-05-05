merchant = true
name = "Test Merchant 1"
player = instance_find(PlayerObject, 0)

if HasFlag("Potion") {
	ds_list_add(textList, "Oh hey there!")
	ds_list_add(iconList, sprite_index)
	ds_list_add(nameList, "Morlock")
}
else {
	ds_list_add(textList, "Hssss!!")
	ds_list_add(iconList, sprite_index)
	ds_list_add(nameList, "Morlock")
}