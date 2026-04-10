// Inherit the parent event
if (!HasFlag("Potion") or (HasFlag("Potion") and HasFlag("PotionCure"))) {
event_inherited();
} 

