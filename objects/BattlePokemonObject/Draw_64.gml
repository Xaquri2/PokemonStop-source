if (enableDrawing)
{
	var xOffset = 0
	var yOffset = view_get_wport(0)*0.05
	if (playerTeam)
	{
		xOffset = view_get_wport(0)*0.4
		yOffset = view_get_hport(0)*0.45
	}
	
	draw_sprite_ext(MenuSprite, 0, xOffset+view_get_wport(0)*0.12, yOffset+view_get_hport(0)*0.1,
	12.5, 5, image_angle, c_grey, image_alpha)

	//Name
	var name = GetName(pkmnInfo)
	var nameSize = 2
	if (string_width(name) > 75) nameSize = 1.5
	if (string_width(name) > 100) nameSize = 1.25
	draw_text_transformed(xOffset+view_get_wport(0)*0.14, yOffset+view_get_hport(0)*0.11, name, nameSize, nameSize, image_angle)

	//Level
	var level = GetLevel(pkmnInfo)
	draw_text_transformed(xOffset+view_get_wport(0)*0.3, yOffset+view_get_hport(0)*0.11, string_concat("Level: ", level), 2, 2, image_angle)

	//Gender
	var gender = GetGender(pkmnInfo)
	var genderFrame = 0
	if (gender == "Female") genderFrame = 1

	draw_sprite_ext(GenderSprite, genderFrame, xOffset+view_get_wport(0)*0.48, yOffset+view_get_hport(0)*0.11,
	1.5, 1.5, image_angle, image_blend, image_alpha)

	//Health Bar
	var baseHP = GetHPStat(GetPokemonFinalStats(name, level))
	var percentage = GetHealth(pkmnInfo)/ds_list_find_value(GetPokemonFinalStats(name, level), 0)*100
	draw_text_transformed(xOffset+view_get_wport(0)*0.14, yOffset+view_get_hport(0)*0.15,
	string_concat("HP: ", floor(percentage), "% (", GetHealth(pkmnInfo), "/", baseHP, ")"), 1.5, 1.5, image_angle)

	draw_sprite_ext(BarSprite, 1, xOffset+view_get_wport(0)*0.14, yOffset+view_get_hport(0)*0.18,
	12.5*(percentage/100), 1.2, image_angle, image_blend, image_alpha)

	draw_sprite_ext(BarSprite, 0, xOffset+view_get_wport(0)*0.14, yOffset+view_get_hport(0)*0.18,
	12.5*(percentage/100), 1.2, image_angle, image_blend, image_alpha)

	//Experience Bar
	percentage = GetExpPercentage(pkmnInfo)
	draw_text_transformed(xOffset+view_get_wport(0)*0.14, yOffset+view_get_hport(0)*0.2,
	string_concat("EXP: ", GetExp(pkmnInfo)), 1.5, 1.5, image_angle)

	draw_sprite_ext(ExpBarSprite, 1, xOffset+view_get_wport(0)*0.14, yOffset+view_get_hport(0)*0.225,
	12.5*(percentage/100), 1.2, image_angle, image_blend, image_alpha)

	draw_sprite_ext(ExpBarSprite, 0, xOffset+view_get_wport(0)*0.14, yOffset+view_get_hport(0)*0.225,
	12.5*(percentage/100), 1.2, image_angle, image_blend, image_alpha)

	//Status
	if (status != "None")
	{
		var color = GetStatusColor(status)
		var xPos = xOffset+view_get_wport(0)*0.48
		var yPos = yOffset+view_get_hport(0)*0.225

		CenterTextPosition()
		draw_roundrect_color(xPos-string_width(status)/2*1.5-10, yPos-string_height(status)/2*1.5-10,
		xPos+string_width(status)/2*1.5+10, yPos+string_height(status)/2*1.5+10,color,color,false)
		draw_text_transformed(xPos, yPos, status, 1.5, 1.5, image_angle)
		ResetTextPosition()
	}
	
	
}

