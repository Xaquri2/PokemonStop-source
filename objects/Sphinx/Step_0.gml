// Inherit the parent event
event_inherited();

if (RiddleSolved && !fading_started) {
	fading_started = true;
	ShadowBall.image_alpha -= 0.03; 
	alarm[3] = 20;
	instance_destroy(inst_C8243E2)
	instance_destroy(inst_6D99074A)
	instance_destroy(inst_1CCFE091)
	instance_destroy(inst_2ACC051E)
}
