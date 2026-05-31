var dialogue = instance_create_layer(x,y,"UIElements",BattleTextboxObject)
dialogue.textList = textList
if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)