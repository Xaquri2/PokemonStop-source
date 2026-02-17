//if (instance_exists(TextSequenceSummoner2) && instance_exists(TextboxObject)) {
//    seen_textbox_after_set2 = true;
//}
//
//if (!queued_presskey && !instance_exists(TextboxObject) && instance_exists(TextSequenceSummoner2) && !instance_exists(PressKeyToContinueText_Enter)) {
//	queued_presskey = true;
//	alarm[1] = 20
//	}
//	


if (instance_exists(TextSequenceSummoner2) && instance_exists(TextboxObject)) {
    seen_textbox_after_set2 = true;
}

if (!queued_presskey
    && instance_exists(TextSequenceSummoner2)
    && !instance_exists(PressKeyToContinueText_Enter)) {

    queued_presskey = true;
    alarm[1] = 20;
}
