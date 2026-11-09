if (global.torch and global.torchPower > 0)
{
	// Match the filled edge and vertical center of the torch's GUI meter.
	var part = instance_create_depth(725+90*global.torchPower,90+32,depth-100,FireParticle)
	part.vspeed = random_range(-1.5,-0.5)
	part.circleRadius = floor(random_range(4,6))
	part.scaleDown = true
	part.drawInGUI = true
}
// Keep checking while off or empty so enabling/refueling restarts the flame.
alarm[3] = 2
