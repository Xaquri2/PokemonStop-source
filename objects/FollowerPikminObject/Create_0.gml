event_inherited();

image_xscale = 0.3
image_yscale = 0.5
randomizePosition = true

if instance_exists(FollowerPikminObject) {
	if global.followerType == "Mary" {
		CountPlace = instance_number(FollowerPikminObject) + 1
		show_debug_message(string_concat("Pikmin #", CountPlace))
	}
	else {
		CountPlace = instance_number(FollowerPikminObject)
		show_debug_message(string_concat("Pikmin #", CountPlace))
	}
}
