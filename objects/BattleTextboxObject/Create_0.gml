battle = instance_find(BattleObject, 0)

inactive = false

textList = ds_list_create()
interruptedTextList = ds_list_create()

currentText = 0
charCounter = 0
charNumber = 0

moveName = ""
playerMoveName = ""
enemyMoveName = ""
playerPkmn = ds_list_create()
enemyPkmn = ds_list_create()
nextPkmn = noone

playerDamage = 0
enemyDamage = 0

recoil = false
pRecoilDamage = 0
eRecoilDamage = 0

whoAttacked = ""
endBattle = false
defeat = false

expGaining = false
expGainValue = 0

newMoveTrigger = false
leveledUp = false
listLevelUpMoves = ds_list_create()

damaging = false
damageValue = 0

flash = false
flashMode = 1

switchIndex = -1
nextPkmnIndex = -1
switching = false
catching = false
timesBobbed = 0

battleFlag = ""

alarm[5] = 1

audio_play_sound(Ding2, 1, false)

GodzillaFainting = false
