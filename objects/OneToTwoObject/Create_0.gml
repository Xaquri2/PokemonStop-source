persistent = true;

image_speed = 1;
image_index = 0;

// prevent duplicate cutscenes
if (instance_number(OneToTwoObject) > 1) instance_destroy();
