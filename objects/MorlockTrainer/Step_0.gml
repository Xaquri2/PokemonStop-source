// Refresh before the parent can start an encounter; leave active dialogue intact.
var disguised = (HasFlag("Potion") and !HasFlag("PotionCure")) or global.morlockTimer > 0
if (!triggered and !instance_exists(TextboxObject))
{
	if (!variable_instance_exists(id, "morlockDialogueDisguised"))
		RefreshMorlockTrainerDialogue(id)
	else if (morlockDialogueDisguised != disguised)
		RefreshMorlockTrainerDialogue(id)
}

// Inherit the parent event
event_inherited();



