var newText = ds_list_find_value(textList, currentText)
var count = string_count("used", newText)
if (count > 0) 
{
	alarm[1] = GetMoveAnimationTime(moveName)
}