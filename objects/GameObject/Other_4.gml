playerMoved = false
targetRoom = noone
if (fade) fade = false
if (warp and targetWarp == "None") warp = false

if (room != RoomBattle and GetRoomName(previousRoom) != GetRoomName(room)) instance_create_layer(0,0,"UserInterface",RoomNameObject)

if (room == loadRoom)
{
	loadRoom = noone
	alarm[0] = 1
}