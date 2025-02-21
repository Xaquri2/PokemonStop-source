// Get the camera view coordinates and dimensions

var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);
var view_width = camera_get_view_width(view_camera[0]);
var view_height = camera_get_view_height(view_camera[0]);

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

draw_sprite_ext(sprite_index, image_index, view_x+180, view_y+view_height-32, 7, 2, image_angle, image_blend, image_alpha)
draw_sprite_ext(ds_list_find_value(iconList, currentText), 0, view_x+32, view_y+view_height-32, 0.75, 0.75, image_angle, image_blend, image_alpha)

draw_set_halign(fa_center)
draw_set_valign(fa_middle)

for (var i = 0; i < ds_list_size(nameList2); i++)
{
	var name2 = ds_list_find_value(nameList2, i)
	draw_text_transformed(view_x+32, view_y+view_height-65-10*(ds_list_size(nameList2)-i-1), name2, 0.75, 0.75, image_angle)
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)

var ogText = ds_list_find_value(textList, currentText)
var text = string_copy(ogText, 0, charNumber)
var counter = 0
var xOffset = 0
var yOffset = 0
for (var i = 1; i <= string_length(text); i++)
{
	counter++
	if (string_char_at(text, i) == " " and counter >= 30)
	{
		counter = 0
		xOffset = 0
		yOffset += 10
	}
	else
	{
		xOffset += 6
	}
	draw_text_transformed(view_x+70+xOffset, view_y+view_height-54+yOffset, string_char_at(text, i),0.5, 0.5, image_angle)
}