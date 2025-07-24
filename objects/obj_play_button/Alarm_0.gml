var game = instance_find(GameObject, 0)
game.warp = true
game.fade = true

if (game.loadRoom != noone) game.targetRoom = game.loadRoom
else game.targetRoom = Mallet_Town