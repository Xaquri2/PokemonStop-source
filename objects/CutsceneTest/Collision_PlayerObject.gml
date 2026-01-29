if (play_cutscene && !instance_exists(CutsceneObject)) {
    var cs = instance_create_depth(0, 0, -100000, CutsceneObject);
    cs.sprite_index = cutscene_sprite;
    cs.image_index = 0;
    cs.image_speed = 1;
}