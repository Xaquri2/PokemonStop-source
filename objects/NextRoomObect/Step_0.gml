//if (instance_exists(TextSequenceSummoner2) && instance_exists(TextboxObject)) {
//    seen_textbox_after_set2 = true;
//}
//
//if (!queued_presskey && !instance_exists(TextboxObject) && instance_exists(TextSequenceSummoner2) && !instance_exists(PressKeyToContinueText_Enter)) {
//	queued_presskey = true;
//	alarm[1] = 20
//	}
//	

if (instance_exists(TextSequenceSummoner) && instance_exists(TextboxObject_GINKGO_DIALOGUE)) {
    seen_textbox_after_set1 = true;
}

//if seen_textbox_after_set1 == true {
//	if (!instance_exists(TextboxObject_GINKGO_DIALOGUE) and !instance_exists(TextSequenceSummoner2)) {
//		instance_create_layer(300,300,"Instances",TextSequenceSummoner2)
//	}
//}

if (instance_exists(TextSequenceSummoner2) && instance_exists(TextboxObject_GINKGO_DIALOGUE)) {
    seen_textbox_after_set2 = true;
}

if (!queued_presskey
    && instance_exists(TextSequenceSummoner2)
    && !instance_exists(PressKeyToContinueText_Enter)) {

    queued_presskey = true;
    alarm[1] = 20;
}


//if (!instance_exists(TextboxObject_GINKGO_DIALOGUE) and ) {
//	dll_cdecl
//}