// Inherit the parent event
event_inherited();
	
if (!fading && (HasFlag("KiddFunk_inst_1")) && !instance_exists(TextboxObject)) fading = true;

if (fading) {
    image_alpha = max(0, image_alpha - fade_spd);
    if (image_alpha == 0) instance_destroy();
}
