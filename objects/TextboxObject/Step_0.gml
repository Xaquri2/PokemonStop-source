var text = ds_list_find_value(textList, currentText)
if (charNumber < string_length(text))
{
	charCounter++
	if (charCounter >= charCounterMax)
	{
		var lastChar = string_char_at(text, charNumber)
		if (lastChar == "!" or lastChar == ".") charCounterMax = 12
		else if (lastChar == "," or lastChar == ";") charCounterMax = 6
		else charCounterMax = 2

		charCounter = 0
		charNumber++
	}
}

face_timer++;
if (face_timer >= room_speed) { // 1 FPS
    face_timer = 0;
    face_frame++;
}

//if (room == EndCreditsRoom) {
//	y = lerp(y, y-1, 0.6)
//}




