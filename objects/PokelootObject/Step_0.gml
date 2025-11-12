if (ds_list_find_index(global.flags, "StarterChosen") != -1)
{
	if (obtainable) obtainable = false
}
else
{
	if (obtainable and GetNPCFlag("Ginkgo") != "ChoosingDefaultDialogue") obtainable = false
	else if (!obtainable and GetNPCFlag("Ginkgo") == "ChoosingDefaultDialogue") obtainable = true
}