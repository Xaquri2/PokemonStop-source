global.money += 100
instance_destroy(self)
audio_play_sound(CoinSound,1,0)
instance_create_layer(x,y,"UserInterface",Plus100Text)