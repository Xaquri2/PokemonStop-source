if (string_count("Starter", itemTag) > 0 and ds_list_find_index(global.flags, "StarterChosen") == -1)
{
	ds_list_add(global.flags, itemTag)
	ds_list_add(global.flags, "StarterChosen")
	SetNPCFlag("Ginkgo", "StarterChosen")
}
