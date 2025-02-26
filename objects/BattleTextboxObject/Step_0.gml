if (charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charCounter++
	if (charCounter >= 2) 
	{
		charCounter = 0
		charNumber++
	}
}