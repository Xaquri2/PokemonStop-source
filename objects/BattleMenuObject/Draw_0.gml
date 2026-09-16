// Get the camera view coordinates and dimensions

var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);
var view_width = camera_get_view_width(view_camera[0]);
var view_height = camera_get_view_height(view_camera[0]);

if (mode == "Choosing")
{
	draw_sprite_ext(sprite_index, image_index, view_width/2, view_y+view_height-36, 8, 2, image_angle, image_blend, image_alpha)
	draw_text_transformed(40, view_y+view_height-60, "Choose an option", 0.75, 0.75, image_angle)

	var xOffset = 1.7
	var yOffset = 48
	for (var i = 0; i < ds_list_size(optionsList); i++)
	{
		if (i == 2)
		{
			xOffset = 1.7
			yOffset = 20
		}

		draw_sprite_ext(sprite_index, image_index, view_width/xOffset, view_y+view_height-yOffset-2, 1.5, 0.75, image_angle, image_blend, image_alpha)

		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		if (i == currentOption) draw_set_color(c_yellow)
		draw_text_transformed(view_width/xOffset, view_y+view_height-yOffset-2,ds_list_find_value(optionsList, i), 0.8, 0.8, image_angle)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)

		xOffset -= 0.4
		draw_set_color(c_white)
	}
}
else if (mode == "Moves")
{
	var pkmn = -1
	while (pkmn == -1)
	{
		for (var i = 0; i < instance_number(BattlePokemonObject); i++)
		{
			pkmn = instance_find(BattlePokemonObject, i)
			if (pkmn.playerTeam) break
			else pkmn = -1
		}
	}

	var pkmnInfo = pkmn.pkmnInfo
	var pkmnLevel = GetLevel(pkmnInfo)
	var pkmnName = GetName(pkmnInfo)
	optionsList = GetMoves(pkmnInfo)

	var moveName = ds_list_find_value(GetMoves(pkmnInfo), currentOption)
	var moveType = GetMoveType(moveName)
	var moveTotalPP = GetMovePP(moveName)
	var moveCurrentPP = (ds_list_find_value(GetMovePPList(pkmnInfo), currentOption))
	var movePPString = string_concat(moveCurrentPP, " / ", moveTotalPP)

	draw_sprite_ext(sprite_index, image_index, view_width/2, view_y+view_height-36, 8, 2, image_angle, image_blend, image_alpha)
	if (moveName != undefined)
	{
		draw_text_transformed(view_width-32-string_width(moveType), view_y+view_height-60, moveType, 0.75, 0.75, image_angle)
		draw_text_transformed(view_width-32-string_width(movePPString), view_y+view_height-40, movePPString, 0.75, 0.75, image_angle)
	}
	
	var xOffset = 4.75
	var yOffset = 48
	for (var i = 0; i < ds_list_size(optionsList); i++)
	{
		if (i == 2)
		{
			xOffset = 4.75
			yOffset = 20
		}

		draw_sprite_ext(sprite_index, image_index, view_width/xOffset, view_y+view_height-yOffset-2, 1.5, 0.75, image_angle, image_blend, image_alpha)

		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		if (i == currentOption) draw_set_color(c_yellow)
		draw_text_transformed(view_width/xOffset, view_y+view_height-yOffset-2,ds_list_find_value(optionsList, i), 0.4, 0.4, image_angle)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		
		var MovePP = ds_list_find_value(GetMovePPList(pkmnInfo), i);
		
		if (MovePP <= 0) {
		draw_sprite_ext(
        BigRedXSprite, 0,
        view_width / xOffset,
        view_y + view_height - yOffset - 2,
        0.5, 0.5,
        image_angle, c_white, image_alpha
			);
		}

		xOffset -= 2.2
		draw_set_color(c_white)
	}
}
