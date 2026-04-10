if (HasFlag("Potion")) {
ds_list_add(textList, "Eyy, fellow Morlock, what can I get ya??","Ya got Human Broth over there in the pot,","And next to that is Human Stew and Human Porridge.","Help yourself!")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index)
ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock")
}

else {
ds_list_add(textList, "Hsss?")
ds_list_add(iconList, sprite_index)
ds_list_add(nameList, "Morlock")
}