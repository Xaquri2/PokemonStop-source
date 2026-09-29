fadeAlpha = 0
fadeCount = 0
fadeDir = 1
fadingIntro = true

playerX = 0
playerY = 0
playerRoom = noone

trainerX = 0
trainerY = 0

playerPkmn = noone
enemyPkmn = noone

playerTeam = global.playerParty
enemyTeam = ds_list_create()
enemySprite = noone
enemyName = ""
enemyObjectType = noone

playerFieldEffects = ds_list_create()
enemyFieldEffects = ds_list_create()

isWild = false
runAttempts = 0

ending = false
defeat = false
escaped = false
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

cloud_level = 1;
cloud_target = 0.5;

currentPikmin = noone
pikminList = ds_list_create()
battleParticipants = ds_list_create()
repeat (global.pikminCount) AddPokemonTrainer(pikminList, ds_list_size(pikminList), "Pikmin", 5, GetRandomGender(50), PikminIdleSprite)

Fluxxed = false
Fluxxed2 = false