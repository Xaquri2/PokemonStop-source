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
		
		// Draw outline
		draw_set_color(c_black);
		for (var j = -1; j < 2; j++)
		{
			for (var k = -1; k < 2; k++)
			{
				draw_text_transformed(view_x+view_width*0.15+j, view_y+view_height-85-10*(ds_list_size(nameList2)-i-1)+k, name2, 0.75*scalePerc, 0.75*scalePerc, image_angle)
			}
		}

		// Draw text
		draw_set_color(c_white);
		draw_text_transformed(view_x+view_width*0.15, view_y+view_height-85-10*(ds_list_size(nameList2)-i-1), name2, 0.75*scalePerc, 0.75*scalePerc, image_angle)
	}

	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}

	//Text box sprite: 
draw_sprite_ext(sprite_index, image_index, view_x+view_width*0.58, view_y+view_height-42, 8.9*scalePerc, 2.2, image_angle, image_blend, image_alpha)
if (!ds_list_empty(iconList)) 
{
		//Box that the character's face goes in: 
	draw_sprite_ext(sprite_index, image_index, view_x+view_width*0.15, view_y+view_height-42, 2.2*scalePerc, 2.2*scalePerc, image_angle, image_blend, image_alpha)

		// Character face sprite (auto-fit)
		var spr = ds_list_find_value(iconList, currentText);
		var maxf = sprite_get_number(spr);
		face_frame = face_frame mod maxf;
		
		// where the face should be centered
		var cx = view_x + view_width * 0.15;
		var cy = view_y + view_height - 44;
		var bottom_y = view_y + view_height - 32; // this is the bottom line you want
		
		// how big the face area is (tweak these)
		var box_w = 60 * scalePerc;
		var box_h = 60 * scalePerc;
		
		// sprite source size
		var sw = sprite_get_width(spr);
		var sh = sprite_get_height(spr);
		
		// scale to FIT (keeps aspect ratio)
		var s = max(box_w / sw, box_h / sh);
		
		// draw centered, with origin centered (see note below)
		draw_sprite_ext(spr, face_frame, cx, cy, s, s, 0, c_white, 1);


}

var ogText = ds_list_find_value(textList, currentText)
var text = string_copy(ogText, 0, charNumber)

// Draw outline
//draw_set_color(c_black);
//for (var i = -1; i < 2; i++)
//{
//	for (var j = -1; j < 2; j++)
//	{
//		draw_text_ext_transformed(view_x+view_width*0.333+i, view_y+view_height-54+j, text, 16, 320, 0.5*scalePerc, 0.5*scalePerc, image_angle)
//	}
//}

// Draw text
draw_set_color(c_white);
draw_text_ext_transformed(view_x+view_width*0.333, view_y+view_height-70, text, 16, 320, 0.8*scalePerc, 0.8*scalePerc, image_angle)