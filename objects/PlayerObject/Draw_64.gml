draw_set_alpha(1-game.fadeAlpha)
draw_text(20,50,string_concat("$", global.money))

var color = c_black
draw_rectangle(20,80,120,100,false)
draw_rectangle_colour(25,85,25+90,95,color,color,color,color,false)

if (global.torchPower > 0)
{
	color = c_orange
	draw_rectangle_colour(25,85,25+90*global.torchPower,95,color,color,color,color,false)
}
draw_set_alpha(1)