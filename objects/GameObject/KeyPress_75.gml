//var layer_id = layer_get_id("Gash");
layer_enable_fx("Gash", true);

if (HasFlag("Potion")) {
	if (!HasFlag("PotionCure")) ds_list_add(global.flags, "PotionCure")
}
else ds_list_add(global.flags, "Potion")