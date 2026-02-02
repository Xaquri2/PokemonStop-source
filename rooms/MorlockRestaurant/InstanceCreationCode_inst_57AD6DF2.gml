if (global.potion == true) {
ds_list_add(textList, "Food is mere fuel -- I have no interest in it!","I subsist off pure HARD WORK.","I'm here because of the ambiance ONLY.","Tho I don't count those human bone chips as 'food', as they don't fit into the same category.","I enjoy those for their ARTISTIC MERIT. It's completely different!")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index,sprite_index)
ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock","Morlock")
}
else {
ds_list_add(textList, "Hsss!")
ds_list_add(iconList, sprite_index)
ds_list_add(nameList, "Morlock")
}