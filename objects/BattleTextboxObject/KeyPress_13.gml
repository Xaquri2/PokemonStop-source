if (charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charNumber = string_length(ds_list_find_value(textList, currentText))
	charCounter = 0
}
else
{
	if (currentText+1 >= ds_list_size(textList))
	{
		instance_destroy(id)
	}
	else
	{
		currentText++
		charCounter = 0
		charNumber = 0
	}
}