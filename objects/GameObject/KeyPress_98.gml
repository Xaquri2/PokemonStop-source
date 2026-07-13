show_debug_message("===== Existing Instances =====");

with (all)
{
    show_debug_message(string(id) + " : " + object_get_name(object_index));
}

show_debug_message("==============================");

show_debug_message("OptionObject: " + string(instance_exists(OptionObject)));
show_debug_message("BattleMenuObject: " + string(instance_exists(BattleMenuObject)));
show_debug_message("MerchantMenuObject: " + string(instance_exists(MerchantMenuObject)));
show_debug_message("PlayerObject: " + string(instance_exists(PlayerObject)));