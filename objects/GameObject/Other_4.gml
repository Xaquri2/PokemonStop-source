playerMoved = false
targetRoom = noone
if (fade) fade = false

if (warp and targetWarp == "None") 
{
	warp = false
}

if (targetWarp = "Random") alarm[2] = 1

if (room != RoomBattle and room != RoomBattleGodzilla and GetRoomName(previousRoom) != GetRoomName(room)) instance_create_depth(0,0,depth+1000000,RoomNameObject)

if (room == loadRoom)
{
	loadRoom = noone
	alarm[0] = 1
}