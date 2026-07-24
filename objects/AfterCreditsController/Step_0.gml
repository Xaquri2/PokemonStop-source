with (CameraObject) {
	if x < 433 {
		x = lerp(x,x+2,2)
		if y > 384 {
			y = lerp(y,y-2,2)
		}
	}
}

if CameraObject.x > 432 {
	cameraArrived = true
}
	
	
if cameraArrived == true {
	if (!alarmStarted)
	{
	    alarm[1] = 64;
	    alarmStarted = true;
	}
}

if pauseOver == true {
	with (DreamTentAFTERCREDITSCENE) {
		image_alpha += 0.05
		WarpSoundStart = true
	}
}

if DreamTentAFTERCREDITSCENE.image_alpha < 1 {
	instance_create_layer(433,384,"Instances",AfterCreditsMagic) 
}

if DreamTentAFTERCREDITSCENE.image_alpha = 1 {
		if (!alarmStarted2)
	{
	    alarm[2] = 100;
	    alarmStarted2 = true;
	}
}

if pauseOver2 == true {
	GameObject.fade = true;
	GameObject.targetRoom = RouteMinusOneBottom
	GameObject.warp = true
}
