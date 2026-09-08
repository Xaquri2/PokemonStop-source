draw_set_alpha(1-game.fadeAlpha)

#region Draw money
if (room == GinkoIntroRoom) {	
}
else {
	draw_sprite_ext(PokeDollarSprite,0,820,55,2.5,2.5,0,c_white,1)	
	draw_set_color(c_black);
	draw_text_transformed(830,30,string_concat(global.money),2,3,0)
	draw_set_color(c_white);
	draw_text_transformed(833,30,string_concat(global.money),2,3,0)
}
#endregion

#region Draw Torch 
if HasItem("Torch Fuel") {
	 //draw_text(725,85,"Haz Torch")
	 if !HasFlag("Torch") {
		ds_list_add(global.flags, "Torch")
	 }
 }
if HasItem("Super Torch Fuel") {
	if !HasFlag("Torch") {
		ds_list_add(global.flags, "Torch")
	}
 }
if HasItem("Ultra Torch Fuel") {
	if !HasFlag("Torch") {
		ds_list_add(global.flags, "Torch")
	}
 }
 if instance_exists(MenuObject) {}
 else {
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
 }
#endregion

#region Draw your Pokemon's name
if (room == GinkoIntroRoom) {	
}
else if (ds_list_size(global.playerParty) > 0)
{
	draw_text(850,120,GetName(ds_list_find_value(global.playerParty, 0)))
}
#endregion

#region Draw controls
if (room == GinkoIntroRoom) {	
}
else {
	
	if ControlsHidden == false {
	//draw_sprite_ext(PokeDollarSprite,0,820,55,2.5,2.5,0,c_white,1)
	draw_set_color(c_black);
	draw_text_transformed(30,830,"Arrow Keys or WASD = Move",1.5,2.1,0)
	draw_text_transformed(30,856,"E = Menu",1.5,2.1,0)
	draw_text_transformed(30,881,"Enter = Talk (if person nearby)",1.5,2.1,0)
	draw_text_transformed(30,910,"CTRL = 2x game speed",1.5,2.1,0)
	draw_text_transformed(30,800,"H = Hide Controls",1.5,2,0)
	
	draw_set_color(c_white);
	draw_text_transformed(33,830,"Arrow Keys or WASD = Move",1.5,2,0)
	draw_text_transformed(33,856,"E = Menu",1.5,2,0)
	draw_text_transformed(33,881,"Enter = Talk (if person nearby)",1.5,2,0)
	draw_text_transformed(33,910,"CTRL = 2x game speed",1.5,2,0)
	draw_text_transformed(33,800,"H = Hide Controls",1.5,2,0)
	}
	else {
		if instance_exists(TextboxObject) {
		}
		else {
		draw_set_color(c_black);
		draw_text_transformed(30,910,"H = Show Controls",1.5,2,0)
		draw_set_color(c_white);
		draw_text_transformed(33,910,"H = Show Controls",1.5,2,0)
		}
}
}
#endregion

#region Draw Morlock timer
if (global.morlockTimer > 0)
{
    draw_sprite_ext(
        PlayerMorlockFACESPRITE,
        0,
        310,
        877,
        2,
        2,
        0,
        c_white,
        1
    );

    var totalSeconds = ceil(global.morlockTimer / 60);
    var minutes = floor(totalSeconds / 60);
    var seconds = totalSeconds mod 60;

    var secondsText = string(seconds);
    if (seconds < 10)
    {
        secondsText = "0" + secondsText;
    }

    var timerText = string(minutes) + ":" + secondsText;

    draw_set_color(c_black);
    draw_text_transformed(400, 870, timerText, 5, 6, 0);

    draw_set_color(c_white);
    draw_text_transformed(403, 870, timerText, 5, 6, 0);
}
#endregion

#region Draw Pikmin Count
if (instance_exists(TextboxObject)) {}
else {
	if (instance_number(FollowerPikminObject) > 0) {
	
		draw_sprite_ext(PikminFaceSprite, 0, 770, 867, 1.4, 1.4, 0, c_white, 1);
	
		draw_set_color(c_black);
		draw_text_transformed(800,870,instance_number(FollowerPikminObject),5,6,0)
		draw_set_color(c_white);
		draw_text_transformed(803,870,instance_number(FollowerPikminObject),5,6,0)
	
		if (HasFlag("StarterChosen")) {
			draw_set_color(c_black);
			draw_text_transformed(790,850,"Alt = Catch",1,1,0)
			draw_set_color(c_white);
			draw_text_transformed(793,850,"Alt = Catch",1,1,0)
		}
	}
}
#endregion