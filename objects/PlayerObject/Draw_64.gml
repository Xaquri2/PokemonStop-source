draw_set_alpha(1-game.fadeAlpha)
draw_text(20,50,string_concat("$", global.money))

if (global.torch) draw_text(25,85,"Press T to disable the Torch")
else draw_text(25,85,"Press T to enable the Torch")

var color = c_black
draw_rectangle(20,80+32,120,100+32,false)
draw_rectangle_colour(25,85+32,25+90,95+32,color,color,color,color,false)

if (global.torchPower > 0)
{
	color = c_orange
	draw_rectangle_colour(25,85+32,25+90*global.torchPower,95+32,color,color,color,color,false)
}
draw_set_alpha(1)