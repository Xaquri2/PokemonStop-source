// BadgeDoorObject already owns the badge interaction and creates the warp.
// Once it has finished that sequence it destroys itself, which is the exact
// moment this visual overlay should begin opening.
if (instance_number(BadgeDoorObject) == 0)
{
    if (image_index < image_number - 1)
    {
        image_speed = 0.3;
    }
    else
    {
        image_speed = 0;
        image_index = image_number - 1;
    }
}

if (TowerdoorOpened == false) && (instance_number(BadgeDoorObject) == 0) {
	audio_play_sound(TowerDoor,1,0)
	TowerdoorOpened = true
}