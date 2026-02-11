alarm[10] = cutsceneSpeed

if (cutsceneFrame+1 < sprite_get_number(cutsceneSprite)) cutsceneFrame++
else 
{
	cutsceneSprite = noone
	playCutscene = false
}