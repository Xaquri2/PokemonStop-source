event_inherited()
if (alarm[10] > 28) targetColor = c_orange
else if (alarm[10] > 15) targetColor = c_yellow
else targetColor = c_white

image_blend = merge_colour(image_blend, targetColor, 0.2)
image_alpha -= 0.05