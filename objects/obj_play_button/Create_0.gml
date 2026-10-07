event_inherited()
text = "Continue"
var fileName = string_concat("savefile", global.saveFile, ".json")
if (!file_exists(fileName)) instance_destroy(id)