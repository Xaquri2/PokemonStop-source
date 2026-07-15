with (TextboxObject) {
	if (charNumber < string_length(ds_list_find_value(textList, currentText)))
	{
		charNumber = string_length(ds_list_find_value(textList, currentText))
		charCounter = 0
	}
	else
	{
		//Make sound when moving to next text or closing
		audio_play_sound(Ding, 1, false)
		if (currentText+1 >= ds_list_size(textList))
		{
			alarm[1] = 1
		}
		else
		{
			//Make sound only when moving to next text (wont work when closing)
			currentText++
			charCounter = 0
			charNumber = 0
		}
	} 
}

