persistent = true;
visible = true;
depth = -1000000; // super in-front (works for normal draw + helps ordering)

//sprite_index = OneToTwoSprite;

image_speed = 1;
image_index = 0;

// prevent duplicate cutscenes
if (instance_number(CutsceneObject) > 1) instance_destroy();
