var seq_inst = layer_sequence_get_instance(seequence);
if (seq_inst != noone) {
    seq_inst.image_alpha -= 0.02;
    alarm[3] = 1;
}