if (room != RoomBattle)
{	
	if (importantBattle)
	{
		var viewW = view_get_wport(0)
		var viewH = view_get_hport(0)
		var originalScissor = gpu_get_scissor()
		
		gpu_set_scissor(0,viewH*0.3,viewW,viewH*0.3)	
		draw_rectangle_color(viewW-maxOffset+enemySpriteOffset,viewH*0.3,
		viewW+10,viewH*0.6,c_black,c_black,c_black,c_black,false)
		draw_sprite_ext(enemySprite,0,viewW-maxOffset+enemySpriteOffset+maxOffset/2,viewH*0.5,
		GetBattleXscale(enemyName)*5,GetBattleXscale(enemyName)*5,image_angle,image_blend,image_alpha)
		
		gpu_set_scissor(0,viewH*0.4,viewW,viewH*0.3)
		draw_rectangle_color(maxOffset+playerSpriteOffset,viewH*0.4,
		-10,viewH*0.7,c_black,c_black,c_black,c_black,false)
		draw_sprite_ext(PlayerIdleDownSprite,0,maxOffset+playerSpriteOffset-maxOffset/2,viewH*0.6,
		5,5,image_angle,image_blend,image_alpha)
		
		gpu_set_scissor(originalScissor)
	}
	
	draw_set_alpha(fadeAlpha)
	draw_rectangle_color(0,0,view_get_wport(0)*3,view_get_hport(0)*3,
	c_black,c_black,c_black,c_black,false)
	draw_set_alpha(1)
}
else
{
	if (ending)
	{
		draw_set_alpha(fadeAlpha)
		draw_rectangle_color(0,0,view_get_wport(0)*3,view_get_hport(0)*3,
		c_black,c_black,c_black,c_black,false)
		draw_set_alpha(1)
	}
	else
	{
		if (!cutscenePlaying)
		{
			draw_rectangle_color(0,0,view_get_wport(0),topRectValue,
			c_black,c_black,c_black,c_black,false)
			draw_rectangle_color(0,view_get_hport(0),view_get_wport(0),view_get_hport(0)-topRectValue,
			c_black,c_black,c_black,c_black,false)
		}
	}
}