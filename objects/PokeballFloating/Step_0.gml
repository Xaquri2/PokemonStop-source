if (string_count("StarterPokemon", itemTag) > 0)
{
	if (ds_list_find_index(global.flags, "StarterChosen") != -1)
	{
		if (obtainable) obtainable = false
	}
	else
	{
		if (obtainable and GetNPCFlag("Ginkgo") != "ChoosingDefaultDialogue") obtainable = false
		else if (!obtainable and GetNPCFlag("Ginkgo") == "ChoosingDefaultDialogue") obtainable = true
	}
}

rotAngle += 1
if (rotAngle >= 360) rotAngle = 0

if (yOffsetDir > 0)
{
	if (yOffset > -6) yOffset -= 0.6
	else yOffsetDir *= -1
}
else
{
	if (yOffset < 6) yOffset += 0.6
	else yOffsetDir *= -1
}