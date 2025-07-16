fadeAlpha = 0
fadeCount = 0
fadeDir = 1
fadingIntro = true

playerX = 0
playerY = 0

playerPkmn = ds_list_create()
enemyPkmn = ds_list_create()

playerTeam = global.playerParty
enemyTeam = ds_list_create()
enemySprite = noone
enemyName = ""

isWild = false
runAttempts = 0

ending = false

topRectValue = view_get_hport(0)/2
textList = ds_list_create()