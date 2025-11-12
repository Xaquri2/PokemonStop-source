event_inherited();
var list = GetNPCFlagDialogue(name, GetNPCFlag(name))
var isEqual = true
for (var i = 0; i < ds_list_size(list); i++)
{
	if (ds_list_find_value(textList, i) != ds_list_find_value(list, i))
	{
		isEqual = false
		break
	}
}

if (!isEqual) ds_list_copy(textList, list)
ds_list_destroy(list)