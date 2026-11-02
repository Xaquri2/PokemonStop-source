event_inherited()
// Room creation code can override this, but every species starts with a name.
name = object_get_name(object_index)
switch (object_index)
{
	case ApeBall: name = "Ape-Ball"; break
	case BB8: name = "BB-8"; break
	case BoxBot: name = "Box Bot"; break
	case DemoDog: name = "Demo Dog"; break
	case GreenBubble: name = "Green Bubble"; break
	case PacGhost: name = "Pac-Ghost"; break
	case WoobWub: name = "Woob-Wüb"; break
	case YoSter: name = "Yo’ster"; break
}

idleSprite = Human2IdleSprite
walkUpSprite = Human2WalkUpSprite
walkDownSprite = Human2WalkDownSprite
walkRightSprite = Human2WalkRightSprite

battle = false
isWild = true

//AddPokemonTrainer(trainerTeam, 1, "Tribble", floor(random_range(8,15)), GetRandomGender(50), TribbleBattleSprite)
