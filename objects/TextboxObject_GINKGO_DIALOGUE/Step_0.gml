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

if seen == false {
	if (ds_list_find_value(textList, 0) == "I came to this island region to study the strange and, frankly, otherworldly Pokémon that live here. ") {
	layer_sequence_create("Sequence",696,715,GinkgoIntro_Part2)
	seen = true
}
}
if (seen2 == false) {
	if (ds_list_find_value(textList, currentText) == "Oh, and, uh, you can also catch Pokémon with your POKÉBALLS and all that. ") {
	seequence = layer_sequence_create("Sequence",696,715,GinkgoIntro_Part3);
	//alarm[3] = 30
	seen2 = true
}

}


