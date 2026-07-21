x = lerp(x,x + ChoosePlusMinus,ChooseSpeed)
y = lerp(y,y + ChoosePlusMinus2,ChooseSpeed)

image_alpha -= .03

if image_alpha == 0 {
	instance_destroy(self)
}