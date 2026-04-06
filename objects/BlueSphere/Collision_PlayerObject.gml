//touching = true;

//if (instance_number(LadderObject < 10)) {
var ladder = instance_create_layer(323.029,846.535,"Instances",LadderObject);
var ladder2 = instance_create_layer(492.198,561.894,"Instances",LadderObject);
var ladder3 = instance_create_layer(228.315,1021.09,"Instances",LadderObject);

ladder.image_angle = 0.1995087;   // rotation (degrees)
ladder.image_xscale = 1.260907;   // width scale
ladder.image_yscale = 1.772;   // height scale

ladder2.image_angle = 0.1995087;   // rotation (degrees)
ladder2.image_xscale = 1.343;   // width scale
ladder2.image_yscale = 1.747;   // height scale

ladder3.image_angle = 180.91;   // rotation (degrees)
ladder3.image_xscale = 1.691655;   // width scale
ladder3.image_yscale = 2.649208;   // height scale

if playing == false {
	audio_play_sound(snd_button,1,0)
	playing = true
}

//}