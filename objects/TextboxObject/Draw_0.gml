// Get the camera view coordinates and dimensions

var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);
var view_width = camera_get_view_width(view_camera[0]);
var view_height = camera_get_view_height(view_camera[0]);
var scalePerc = view_width/480

if (!ds_list_empty(nameList))
{
	var name = ds_list_find_value(nameList, currentText)
	var nameBreakIndex = 0
	var nameList2 = ds_list_create()
	for (var i = 1; i <= string_length(name); i++)
	{
		if (string_char_at(name, i) == " ")
		{
			ds_list_add(nameList2, string_copy(name, nameBreakIndex, i-nameBreakIndex))
			var a = ds_list_find_value(nameList2, 0)
			a = ds_list_find_value(nameList2, 1)
			a = ds_list_find_value(nameList2, 2)
			nameBreakIndex = i+1
		}
		if (i+1 > string_length(name))
		{
			ds_list_add(nameList2, string_copy(name, nameBreakIndex, i))
		}
	}

	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)

	for (var i = 0; i < ds_list_size(nameList2); i++)
	{
		var name2 = ds_list_find_value(nameList2, i)
		draw_text_transformed(view_x+view_width*0.15, view_y+view_height-65-10*(ds_list_size(nameList2)-i-1), name2, 0.75*scalePerc, 0.75*scalePerc, image_angle)
	}

	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}

draw_sprite_ext(sprite_index, image_index, view_x+view_width*0.5, view_y+view_height-32, 7*scalePerc, 1.75, image_angle, image_blend, image_alpha)
if (!ds_list_empty(iconList)) 
{
	draw_sprite_ext(sprite_index, image_index, view_x+view_width*0.15, view_y+view_height-32, 1.75*scalePerc, 1.75*scalePerc, image_angle, image_blend, image_alpha)
	draw_sprite_ext(ds_list_find_value(iconList, currentText), 0, view_x+view_width*0.15, view_y+view_height-32, 0.75*scalePerc, 0.75*scalePerc, image_angle, image_blend, image_alpha)
}

var ogText = ds_list_find_value(textList, currentText)
var text = string_copy(ogText, 0, charNumber)

// Draw outline
draw_set_color(c_black);
for (var i = -1; i < 2; i++)
{
	for (var j = -1; j < 2; j++)
	{
		draw_text_ext_transformed(view_x+view_width*0.333+i, view_y+view_height-54+j, text, 16, 320, 0.5*scalePerc, 0.5*scalePerc, image_angle)
	}
}

// Draw text
draw_set_color(c_white);
draw_text_ext_transformed(view_x+view_width*0.333, view_y+view_height-54, text, 16, 320, 0.5*scalePerc, 0.5*scalePerc, image_angle)