fadeAlpha = 0
fadeCount = 0
fadeDir = 1
fadingIntro = true

playerPkmn = ds_list_create()
enemyPkmn = ds_list_create()

topRectValue = view_get_hport(0)/2
playerTeam = global.playerParty
enemyTeam = ds_list_create()
enemySprite = noone
enemyName = ""

textList = ds_list_create()