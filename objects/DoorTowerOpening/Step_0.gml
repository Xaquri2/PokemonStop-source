if (ds_list_find_index(global.activatedBadges, "ShadowBadge") != -1) && (ds_list_find_index(global.activatedBadges, "MutantBadge") != -1) && (ds_list_find_index(global.activatedBadges, "RobotBadge") != -1) {
	if (image_index <= 11) {
		image_speed = 1
	}
	else if (image_index == 11) {
		image_speed = 0
		image_index = 11
	}
}