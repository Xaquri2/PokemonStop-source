if (itemTag != "" and ds_list_find_index(global.collectedPokeloot, itemTag) != -1)
{
	instance_destroy(id)
}