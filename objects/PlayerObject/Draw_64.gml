draw_set_alpha(1-game.fadeAlpha)
draw_text(820,50,string_concat("$", global.money))


  //Torch 
if HasItem("Torch Fuel") {
	 //draw_text(725,85,"Haz Torch")
	 ds_list_add(global.flags, "Torch")
 }
if HasItem("Super Torch Fuel") {
	 ds_list_add(global.flags, "Torch")
 }
if HasItem("Ultra Torch Fuel") {
	 ds_list_add(global.flags, "Torch")
 }
if HasFlag("Torch") {
	if (global.torch) draw_text(725,85,"Press T to disable the Torch")
	else draw_text(725,85,"Press T to enable the Torch")

	var color = c_black
	draw_rectangle(720,80+32,820,100+32,false)
	draw_rectangle_colour(725,85+32,725+90,95+32,color,color,color,color,false)

	if (global.torchPower > 0)
	{
		color = c_orange
		draw_rectangle_colour(725,85+32,725+90*global.torchPower,95+32,color,color,color,color,false)
	}
	draw_set_alpha(1)
}

// Draw your Pokemon's name
draw_text(850,120,GetName(ds_list_find_value(global.playerParty, 0)))

