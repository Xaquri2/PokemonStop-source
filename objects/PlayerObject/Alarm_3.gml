if (global.torch and global.torchPower > 0)
{
	var part = instance_create_depth(25+90*global.torchPower,90,depth-100,FireParticle)
	part.vspeed = random_range(-1.5,-0.5)
	part.circleRadius = floor(random_range(4,6))
	part.scaleDown = true
	part.drawInGUI = true
	alarm[3] = 2
}