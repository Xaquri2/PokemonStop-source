

// center alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
//draw_text(x, y, "PRESS 'S' TO SKIP!");

// base size
var base_s = 3;

// how strong the zoom is
var zoom_amount = 0.3;   // try 0.2–0.5

// how fast it zooms
var zoom_speed = 0.005;        // smaller = slower

// oscillating scale
var s = base_s + sin(current_time * zoom_speed) * zoom_amount;

draw_text_transformed(x, y, "PRESS ENTER", s, s, 0);

// reset alignment 
draw_set_halign(fa_left);
draw_set_valign(fa_top);