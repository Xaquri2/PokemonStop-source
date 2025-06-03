draw_text(20,20,string_concat("Speed: ", global.speedUpMultiplier, "x"))

draw_set_alpha(fadeAlpha)
draw_rectangle_color(0,0,view_get_wport(0),view_get_hport(0),
c_black,c_black,c_black,c_black,false)
draw_set_alpha(1)