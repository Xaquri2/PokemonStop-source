image_alpha -= 0.02;   // fade speed; smaller = slower fade

if (image_alpha <= 0) {
    instance_destroy(id); // fully faded out, now delete
} else {
    alarm[0] = 1;       // call this alarm again next step to keep fading
}

