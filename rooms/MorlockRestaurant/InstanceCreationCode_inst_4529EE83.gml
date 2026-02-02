if (global.potion == true) {
	ds_list_add(textList, "I won't eat human meat... it's wrong!","They're intelligent creatures, you know - capable of all the same thoughts & feelings as we are!","Ugh... but I feel so embarrassed, if I refuse to eat human meat, it'll make my date uncomfortable...","But even so, I just can't do it... I couldn't help thinking of those poor, sunlit creatures, dying horribly for my meal...")
	ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index)
	ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock")
}
else {
ds_list_add(textList, "Hsss!")
ds_list_add(iconList, sprite_index)
ds_list_add(nameList, "Morlock")
}