if (instance_exists(CreditsCollider)) {
	if (CreditsCollider.FadingOut == true) && (room != TitleScreen) {
		image_alpha += 0.1
	}
}


if room == TitleScreen {
	image_alpha -= 0.1
	if image_alpha <= 0 {
		instance_destroy(self)
	}
}

draw_self()