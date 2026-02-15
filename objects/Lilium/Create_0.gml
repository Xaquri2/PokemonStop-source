// Inherit the parent event
event_inherited();
name = "Lilium"

hover_time = 0;
hover_speed = 0.05;    // how fast it moves
hover_height = 2;      // how far up/down (pixels)

rock_speed = 0.03;     // how fast it rocks
rock_angle = 3;        // how many degrees left/right

floatDown = false;

homeY   = y;          // original position
baseY   = y; 
maxDrop = 100;         // how far down she can float (pixels)
targetY = baseY;      // where she’s trying to go
vsp     = 0;          // vertical speed

ds_list_add(textList, "Hello?","Oh. We have a visitor.","…","I am Lilium. I’m the gym leader here …",
"Though I find it difficult to focus on such… extraneous pursuits.","You’ve seen, perhaps, my handiwork.",
"The ghostly and shadow Pokémon outside – UMBRIANs, BOOs, etc… Created by me." ,
"That is, I bring human souls back and bind them to this world, in different forms." ,
"My project, you see, is to bring DIVINE KNOWLEDGE to all of your people, you mortals.", "This place – do you know what it is? ")
ds_list_add(nameList, "???","???","???","Lilium","Lilium","Lilium","Lilium","Lilium","Lilium","Lilium")
ds_list_add(iconList,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP)


if (!HasFlag("LiliumFirstDefeatText")) 
{
	ds_list_add(postBattleTextList, "Impossible!!", "GAAAHH !!", "Well… it seems you've earned this badge", 
	"Come back once you’ve completed your journey… and I’d be glad to convert you into one of my … projects.")
	ds_list_add(postBattleNameList, "Lilium","Lilium","Lilium","Lilium")
	ds_list_add(postBattleIconList, LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP)
}
else
{
	ds_list_add(postBattleTextList, "You've already earned your badge.")
	ds_list_add(postBattleNameList, "Lilium")
	ds_list_add(postBattleIconList, LilySprite_CLOSEUP)
}