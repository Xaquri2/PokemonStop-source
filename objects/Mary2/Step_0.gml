// Inherit the parent event
event_inherited();

if (HasFlag("MaryRivalBattle1")) instance_destroy(id)
if (HasFlag("MaryRivalBattle2")) {
	ds_list_add(global.flags, "MaryRivalBattle1")
	global.followerType = "Mary"
	instance_destroy(id)
}

