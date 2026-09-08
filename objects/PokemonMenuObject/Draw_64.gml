draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.08, view_get_hport(0)*0.05,
15, 25, image_angle, image_blend, image_alpha)

if (!summaryMode)
{
	for (var i = 0; i < ds_list_size(global.playerParty); i++)
	{
		if ((i != switchIndex and switchMode) or !switchMode)
		{
			var pkmnInfo = GetPartyMemberInfo(global.playerParty, i)
			var pkmnColor = c_white

			if (GetHealth(pkmnInfo) <= 0) {
				    pkmnColor = c_gray
				}
			draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.12, view_get_hport(0)*(0.1+(0.13*i)),
			12.5, 3, image_angle, c_grey, image_alpha)

			if (selectedIndex == i and !switchMode)
			{
				draw_set_alpha(0.25)
				draw_rectangle(view_get_wport(0)*0.12, view_get_hport(0)*(0.1+(0.13*i)),
				view_get_wport(0)*0.12+sprite_get_width(MenuSprite)*12.5,
				view_get_hport(0)*(0.1+(0.13*i))+sprite_get_height(MenuSprite)*3, false)
				draw_set_alpha(1)
			}

			var sprite = GetSprite(pkmnInfo)
			var pkmnScale = 2
			//CHANGE THIS TO CHANGE PKMN SPRITE SCALE IN PKMN MENU
			switch (GetName(pkmnInfo))
				{
				    case "MissingNo":
				        pkmnScale = 1
				        break
				} 
			draw_sprite_ext(sprite, 0, view_get_wport(0)*0.18, view_get_hport(0)*(0.15+(0.13*i)),
			pkmnScale, pkmnScale, image_angle, pkmnColor, image_alpha) //col:  image_blend
			if (GetHealth(pkmnInfo) <= 0) {
				draw_sprite_ext(BigRedXSprite,0,view_get_wport(0)*0.18, view_get_hport(0)*(0.15+(0.13*i)),1,1,image_angle,c_white,image_alpha)
			}
			draw_set_color(pkmnColor)

			var name = GetName(pkmnInfo)
			draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*(0.11+(0.13*i)), name, 2, 2, image_angle)

			var level = GetLevel(pkmnInfo)
			draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*(0.15+(0.13*i)), string_concat("Level: ", level), 2, 2, image_angle)
			draw_set_color(c_white)

			var gender = GetGender(pkmnInfo)
			var genderFrame = 0
			if (gender == "Female") genderFrame = 1

			draw_sprite_ext(GenderSprite, genderFrame, view_get_wport(0)*0.42, view_get_hport(0)*(0.145+(0.13*i)),
			1.5, 1.5, image_angle, image_blend, image_alpha)
		}
	}

	if (switchMode)
	{
		var pkmnInfo = GetPartyMemberInfo(global.playerParty, switchIndex)
		draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.14, view_get_hport(0)*0.1+128*selectedIndex,
		12.5, 3, image_angle, c_grey, image_alpha)

		draw_set_alpha(0.25)
		draw_rectangle(view_get_wport(0)*0.14, view_get_hport(0)*0.1+128*selectedIndex,
		view_get_wport(0)*0.14+sprite_get_width(MenuSprite)*12.5,
		view_get_hport(0)*0.1+128*selectedIndex+sprite_get_height(MenuSprite)*3, false)
		draw_set_alpha(1)

		var sprite = GetSprite(pkmnInfo)
		
		var sprite = GetSprite(pkmnInfo)
		var switchPkmnScale = 2

		switch (GetName(pkmnInfo)) {
			    case "MissingNo":
			        switchPkmnScale = 1
			        break
			}
		draw_sprite_ext(sprite, 0, view_get_wport(0)*0.2, view_get_hport(0)*0.15+128*selectedIndex,
		switchPkmnScale, switchPkmnScale, image_angle, image_blend, image_alpha)

		var name = GetName(pkmnInfo)
		draw_text_transformed(view_get_wport(0)*0.26, view_get_hport(0)*0.11+128*selectedIndex, name, 2, 2, image_angle)

		var level = GetLevel(pkmnInfo)
		draw_text_transformed(view_get_wport(0)*0.26, view_get_hport(0)*0.15+128*selectedIndex, string_concat("Level: ", level), 2, 2, image_angle)

		var gender = GetGender(pkmnInfo)
		var genderFrame = 0
		if (gender == "Female") genderFrame = 1

		draw_sprite_ext(GenderSprite, genderFrame, view_get_wport(0)*0.44, view_get_hport(0)*0.145+128*selectedIndex,
		1.5, 1.5, image_angle, image_blend, image_alpha)
	}
}
else
{
	var pkmnInfo = GetPartyMemberInfo(global.playerParty, selectedIndex)
	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.12, view_get_hport(0)*0.1,
	12.5, 7.25, image_angle, c_grey, image_alpha)

	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.12, view_get_hport(0)*0.35,
	12.5, 15, image_angle, c_grey, image_alpha)

	//Sprite
	var sprite = GetSprite(pkmnInfo)
	draw_sprite_ext(sprite, 0, view_get_wport(0)*0.18, view_get_hport(0)*0.15,
	2, 2, image_angle, image_blend, image_alpha)

	//Name
	var name = GetName(pkmnInfo)
	draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*0.11, name, 2, 2, image_angle)

	//Level
	var level = GetLevel(pkmnInfo)
	draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*0.15, string_concat("Level: ", level), 2, 2, image_angle)

	//Gender
	var gender = GetGender(pkmnInfo)
	var genderFrame = 0
	if (gender == "Female") genderFrame = 1

	draw_sprite_ext(GenderSprite, genderFrame, view_get_wport(0)*0.42, view_get_hport(0)*0.145,
	1.5, 1.5, image_angle, image_blend, image_alpha)

	//Health Bar
	var baseHP = GetHPStat(GetPokemonFinalStats(name, level))
	var percentage = GetHealth(pkmnInfo)/ds_list_find_value(GetPokemonFinalStats(name, level), 0)*100
	draw_text_transformed(view_get_wport(0)*0.14, view_get_hport(0)*0.2,
	string_concat("HP: ", floor(percentage), "% (", floor(GetHealth(pkmnInfo)), "/", baseHP, ")"), 1.5, 1.5, image_angle)

	draw_sprite_ext(BarSprite, 1, view_get_wport(0)*0.14, view_get_hport(0)*0.23,
	12.5*(percentage/100), 1.2, image_angle, image_blend, image_alpha)

	draw_sprite_ext(BarSprite, 0, view_get_wport(0)*0.14, view_get_hport(0)*0.23,
	12.5*(percentage/100), 1.2, image_angle, image_blend, image_alpha)

	//Experience Bar
	percentage = GetExpPercentage(pkmnInfo)
	draw_text_transformed(view_get_wport(0)*0.14, view_get_hport(0)*0.26,
	string_concat("EXP: ", GetExp(pkmnInfo)), 1.5, 1.5, image_angle)

	draw_sprite_ext(ExpBarSprite, 1, view_get_wport(0)*0.14, view_get_hport(0)*0.3,
	12.5*(percentage/100), 1.2, image_angle, image_blend, image_alpha)

	draw_sprite_ext(ExpBarSprite, 0, view_get_wport(0)*0.14, view_get_hport(0)*0.3,
	12.5*(percentage/100), 1.2, image_angle, image_blend, image_alpha)

	//Status
	if (GetStatus(pkmnInfo) != "None")
	{
		CenterTextPosition()
		draw_text_transformed(view_get_wport(0)*0.45, view_get_hport(0)*0.31,
		GetStatus(pkmnInfo), 1.5, 1.5, image_angle)
		ResetTextPosition()
	}

	//Stats
	for (var i = 0; i < 6; i++)
	{
		var stat = floor(ds_list_find_value(GetPokemonFinalStats(name, level), i))
		var statName = ""
		switch (i)
		{
			case 0:
				statName = "HP: "
				break
			case 1:
				statName = "Attack: "
				break
			case 2:
				statName = "Defense: "
				break
			case 3:
				statName = "Sp. Atk: "
				break
			case 4:
				statName = "Sp. Def: "
				break
			case 5:
				statName = "Speed: "
				break
		}
		draw_text_transformed(view_get_wport(0)*0.16, view_get_hport(0)*(0.38+0.05*i),
		string_concat(statName, stat), 2, 2, image_angle)
	}

	var moves = GetMoves(pkmnInfo)
	var xOffset = 0
	var yOffset = 0
	for (var i = 0; i < ds_list_size(moves); i++)
	{
		if (i == 2)
		{
			xOffset = 0
			yOffset = 64
		}

		draw_sprite_ext(MenuSprite, image_index, view_get_wport(0)*(0.13+xOffset), view_get_hport(0)-300+yOffset, 6, 1.5, image_angle, image_blend, image_alpha)
		if (i == moveIndex) draw_set_color(c_yellow)
		draw_text_transformed(view_get_wport(0)*(0.14+xOffset), view_get_hport(0)-300+yOffset+10,ds_list_find_value(moves, i), 1.5, 1.5, image_angle)

		xOffset += 0.2
		draw_set_color(c_white)
	}
}
