var dialogue = instance_create_depth(x,y,-9999999999999,BattleTextboxObject)
dialogue.textList = textList
if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)