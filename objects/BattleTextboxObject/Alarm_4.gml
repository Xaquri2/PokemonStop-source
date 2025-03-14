var text = ds_list_find_value(textList, currentText)
var count = string_count("used", text)
if (count > 0) alarm[4] = 30

if (currentText+1 >= ds_list_size(textList))
{
	alarm[0] = 15
}
else
{
	currentText++
	charCounter = 0
	charNumber = 0
}