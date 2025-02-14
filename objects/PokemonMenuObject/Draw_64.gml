draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.08, view_get_hport(0)*0.05, 
15, 25, image_angle, image_blend, image_alpha)

if (!summaryMode)
{
	for (var i = 0; i < ds_list_size(global.playerParty); i++)
	{
		var pkmnInfo = GetPartyMemberInfo(i)
		draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.12, view_get_hport(0)*(0.1+(0.13*i)), 
		12.5, 3, image_angle, c_grey, image_alpha)
	
		if (selectedIndex == i) 
		{
			draw_set_alpha(0.25)
			draw_rectangle(view_get_wport(0)*0.12, view_get_hport(0)*(0.1+(0.13*i)), 
			view_get_wport(0)*0.12+sprite_get_width(MenuSprite)*12.5, 
			view_get_hport(0)*(0.1+(0.13*i))+sprite_get_height(MenuSprite)*3, false)
			draw_set_alpha(1)
		}
	
		var sprite = ds_list_find_value(pkmnInfo, 4)
		draw_sprite_ext(sprite, 0, view_get_wport(0)*0.18, view_get_hport(0)*(0.15+(0.13*i)), 
		2, 2, image_angle, image_blend, image_alpha)
	
		var name = ds_list_find_value(pkmnInfo, 1)
		draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*(0.11+(0.13*i)), name, 2, 2, image_angle)
	
		var level = ds_list_find_value(pkmnInfo, 2)
		draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*(0.15+(0.13*i)), string_concat("Level: ", level), 2, 2, image_angle)

		var gender = ds_list_find_value(pkmnInfo, 3)
		var genderFrame = 0
		if (gender == "Female") genderFrame = 1
	
		draw_sprite_ext(GenderSprite, genderFrame, view_get_wport(0)*0.42, view_get_hport(0)*(0.145+(0.13*i)), 
		1.5, 1.5, image_angle, image_blend, image_alpha)
	}
}
else
{
	var pkmnInfo = GetPartyMemberInfo(selectedIndex)
	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.12, view_get_hport(0)*0.1, 
	12.5, 6, image_angle, c_grey, image_alpha)
	
	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.12, view_get_hport(0)*0.35, 
	12.5, 15, image_angle, c_grey, image_alpha)
	
	//Sprite
	var sprite = ds_list_find_value(pkmnInfo, 4)
	draw_sprite_ext(sprite, 0, view_get_wport(0)*0.18, view_get_hport(0)*0.15, 
	2, 2, image_angle, image_blend, image_alpha)
	
	//Name
	var name = ds_list_find_value(pkmnInfo, 1)
	draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*0.11, name, 2, 2, image_angle)
	
	//Level
	var level = ds_list_find_value(pkmnInfo, 2)
	draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*0.15, string_concat("Level: ", level), 2, 2, image_angle)

	//Gender
	var gender = ds_list_find_value(pkmnInfo, 3)
	var genderFrame = 0
	if (gender == "Female") genderFrame = 1
	
	draw_sprite_ext(GenderSprite, genderFrame, view_get_wport(0)*0.42, view_get_hport(0)*0.145, 
	1.5, 1.5, image_angle, image_blend, image_alpha)
	
	//Health Bar
	var percentage = ds_list_find_value(pkmnInfo, 5)
	draw_text_transformed(view_get_wport(0)*0.14, view_get_hport(0)*0.2, 
	string_concat("HP: ", percentage, "%"), 2, 2, image_angle)
	
	draw_sprite_ext(BarSprite, 1, view_get_wport(0)*0.14, view_get_hport(0)*0.25, 
	12.5*(percentage/100), 1.6, image_angle, image_blend, image_alpha)
	
	draw_sprite_ext(BarSprite, 0, view_get_wport(0)*0.14, view_get_hport(0)*0.25, 
	12.5*(percentage/100), 1.6, image_angle, image_blend, image_alpha)
	
	//Stats
	for (var i = 0; i < 6; i++)
	{
		var stat = floor(ds_list_find_value(GetPokemonFinalStats(selectedIndex), i))
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
}