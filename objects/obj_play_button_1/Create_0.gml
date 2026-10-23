event_inherited()
text = "Continue"
var fileName = string_concat("savefile", global.saveFile, ".json")
if (!file_exists(fileName) or instance_number(object_index) > 1) instance_destroy(id)