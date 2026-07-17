draw_sprite_ext(
    sprite_index,
    image_index,
    0,
    0,
    0.979592,
    0.979592,
    image_angle,
    image_blend,
    image_alpha
);

if (DrawPokemonStopText == true) {
	draw_set_font(fnt_button)
	draw_set_colour(c_black)
	draw_text_ext(420,540,"[Pokémon Stop]", -1, -1)
	draw_set_colour(c_white)
}

if (DrawTheEndText == true) {
	draw_set_font(fnt_button)
	draw_text_ext(420,600,"     THE END", -1, -1)
}

if (DrawPressEnterText == true) {
	draw_set_font(fnt_button)
	draw_text_ext(420,800,"Press Enter", -1, -1)
}