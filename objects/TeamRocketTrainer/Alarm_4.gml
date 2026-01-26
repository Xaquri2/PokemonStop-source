if (circuit) {
    // flip moveType
    if (moveType == "horizontal") {
		moveType = "vertical";
		walkTime = 64;
	}
    else moveType = "horizontal";

    alarm[4] = walkTime; // schedule next flip
}
