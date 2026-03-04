fadeAlpha = 0
fadeCount = 0
fadeDir = 1
fadingIntro = true

playerX = 0
playerY = 0

trainerX = 0
trainerY = 0

playerPkmn = noone
enemyPkmn = noone

playerTeam = global.playerParty
enemyTeam = ds_list_create()
enemySprite = noone
enemyName = ""

isWild = false
runAttempts = 0

ending = false
defeat = false
battleFlag = ""

importantBattle = false
spriteIntro = false
maxOffset = 400
enemySpriteOffset = maxOffset
playerSpriteOffset = -maxOffset

topRectValue = view_get_hport(0)/2
textList = ds_list_create()

postBattleTextList = noone
postBattleIconList = noone
postBattleNameList = noone

playCutscene = false
cutsceneVideo = ""
cutscenePlaying = false
cutsceneSurface = -1