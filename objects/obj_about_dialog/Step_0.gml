var guiWidth = display_get_gui_width();
var guiHeight = display_get_gui_height();
var boxWidth = min(800, guiWidth*0.84);
var boxHeight = min(720, guiHeight*0.84);
var boxX = (guiWidth-boxWidth)/2;
var boxY = (guiHeight-boxHeight)/2;
var mouseX = device_mouse_x_to_gui(0);
var mouseY = device_mouse_y_to_gui(0);
var clickedClose = mouse_check_button_pressed(mb_left)
    and point_in_rectangle(mouseX, mouseY, boxX+boxWidth-164, boxY+boxHeight-64,
        boxX+boxWidth-24, boxY+boxHeight-20);

if (keyboard_check_pressed(vk_escape) or keyboard_check_pressed(ord("E"))
    or keyboard_check_pressed(vk_enter) or clickedClose)
{
    instance_destroy();
    exit;
}
if (keyboard_check_pressed(vk_right) or keyboard_check_pressed(vk_down) or mouse_wheel_down())
    pageIndex = min(pageCount-1, pageIndex+1);
if (keyboard_check_pressed(vk_left) or keyboard_check_pressed(vk_up) or mouse_wheel_up())
    pageIndex = max(0, pageIndex-1);
