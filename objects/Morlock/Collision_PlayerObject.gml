// Inherit the parent event
if ((!HasFlag("Potion") or (HasFlag("Potion") and HasFlag("PotionCure"))) and global.morlockTimer == 0) {
event_inherited();
} 