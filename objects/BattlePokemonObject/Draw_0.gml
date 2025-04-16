if (alarm[3] > 0 and flashMode == 1)
{
	gpu_set_fog(true,c_white,0,0);
	draw_self()
	gpu_set_fog(false,c_white,0,0);
}
else draw_self()

var a = GetHealth(pkmnInfo)
var b = GetHealth(ds_list_find_value(global.playerParty, index))

if (a != undefined)
{
	draw_text(x,y+20,floor(hp))
	draw_text(x+20,y+20,floor(a))
	draw_text(x+40,y+20,floor(b))
}