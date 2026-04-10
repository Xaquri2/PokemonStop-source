if (HasFlag("Potion")) {
	ds_list_add(textList, "My date is so beautiful... but...","She doesn't eat human meat!!","That's so noble! She really cares for those creatures!","...Oh Sphinx, I can't eat Human meat in front of her!!","What do I do??","Aggghhhh!!")
	ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index)
	ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock","Morlock","Morlock")
}
else {
ds_list_add(textList, "Hsss!")
ds_list_add(iconList, sprite_index)
ds_list_add(nameList, "Morlock")
}