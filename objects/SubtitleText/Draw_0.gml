//var view_x = camera_get_view_x(view_camera[0]);
//var view_y = camera_get_view_y(view_camera[0]);
//var view_width = camera_get_view_width(view_camera[0]);
//var view_height = camera_get_view_height(view_camera[0]);
//var scalePerc = view_width/480
//
//		// Draw outline
//		draw_set_color(c_black);
//		for (var j = -1; j < 2; j++)
//		{
//			for (var k = -1; k < 2; k++)
//			{
//				draw_text_transformed(view_x+view_width*0.15+j, view_y+view_height-85-10*(ds_list_size(nameList2)-i-1)+k, name2, 0.75*scalePerc, 0.75*scalePerc, image_angle)
//			}
//		}



//draw_set_color(c_white);
//draw_text_transformed(x, y, "A 'PAPER COMPUTER GAMES' Adventure", 2.5, 2.5, 0);


var msg = "A 'PAPER COMPUTER GAMES' Adventure";
var sx = 2.8;
var sy = 2.8;
var ox = 2; // outline thickness in pixels (try 2 if you want thicker)
var oy = 2;

// outline
draw_set_color(c_black);
for (var j = -ox; j <= ox; j++)
{
    for (var k = -oy; k <= oy; k++)
    {
        if (j != 0 || k != 0)
            draw_text_transformed(x + j, y + k, msg, sx, sy, 0);
    }
}

// fill
draw_set_color(c_white);
draw_text_transformed(x, y, msg, sx, sy, 0);


