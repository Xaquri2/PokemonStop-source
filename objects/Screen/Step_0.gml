//depth = -y
depth = -1000000;

var joy = instance_nearest(x,y,NurseJoy)
if (joy.alarm[1] >= 0)
{
	if (alarm[0] == -1) alarm[0] = 15
	
	if (joy.alarm[1] < 180-20*6) displayCount = 6
	else if (joy.alarm[1] < 180-20*5) displayCount = 5
	else if (joy.alarm[1] < 180-20*4) displayCount = 4
	else if (joy.alarm[1] < 180-20*3) displayCount = 3
	else if (joy.alarm[1] < 180-20*2) displayCount = 2
	else if (joy.alarm[1] < 180-20) displayCount = 1
}
else displayCount = 0