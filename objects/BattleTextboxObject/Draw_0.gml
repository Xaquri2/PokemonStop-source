// Get the camera view coordinates and dimensions

var view_x = camera_get_view_x(view_camera[0]);
var view_y = camera_get_view_y(view_camera[0]);
var view_width = camera_get_view_width(view_camera[0]);
var view_height = camera_get_view_height(view_camera[0]);

draw_sprite_ext(sprite_index, image_index, view_width/2, view_y+view_height-32, 8*(view_width/40), 1.75, image_angle, image_blend, image_alpha)

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
	draw_text_transformed(view_x+40+xOffset, view_y+view_height-54+yOffset, string_char_at(text, i),0.5, 0.5, image_angle)
}