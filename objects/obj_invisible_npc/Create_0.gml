event_inherited();
name = npc_name
if (typeof(speech) == "array") {
	for (var i = 0; i < array_length(speech); i++) {
		ds_list_add(textList, speech[i])
	}
}
else if (typeof(speech) == "string") {
	ds_list_add(textList, speech)
}