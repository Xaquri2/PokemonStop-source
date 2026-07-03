if (xaqsetfont == 1) {
	draw_set_font(fnt_button)
}
else if (xaqsetfont == 3) {
	draw_set_font(FontSMALL)
}
else {
	draw_set_font(Font2)
}

if xaqColor == c_yellow {
	draw_set_color(c_yellow)
}
else {
	draw_set_color(c_white);
}
draw_text(x, y, display_text);

//display_text = "TO HAMMER";

