// BattlePokemonObject instances are temporarily absent while a switch animation
// replaces the outgoing Pokemon. Refresh these references instead of keeping the
// one-time values captured by the Create event.
var activeBattle = instance_find(BattleObject, 0)
if (activeBattle == noone)
{
	exit
}

playerPkmn = FindBattlePokemonEntity(activeBattle.playerPkmn)
enemyPkmn = FindBattlePokemonEntity(activeBattle.enemyPkmn)

// Do not accept a menu choice until both on-field Pokemon have spawned.
if (playerPkmn == noone or enemyPkmn == noone)
{
	exit
}

// A textbox owns battle input while a turn is being presented. This also
// prevents a stale textbox from allowing two menus to process the same key.
if (instance_number(BattleTextboxObject) > 0)
{
	exit
}

if (keyboard_check_pressed(vk_enter))
{
	if (mode == "Choosing")
	{
		switch (currentOption)
		{
			case 0:
				var pkmn = -1
				while (pkmn == -1)
				{
					for (var i = 0; i < instance_number(BattlePokemonObject); i++)
					{
						pkmn = instance_find(BattlePokemonObject, i)
						if (pkmn.playerTeam) break
						else pkmn = -1
					}
				}

				var pkmnInfo = pkmn.pkmnInfo
				optionsList = GetMoves(pkmnInfo)

				var struggle = true

				if (!ds_list_empty(optionsList))
				{
					var battle = instance_find(BattleObject, 0)
					var pMoves = GetMoves(battle.playerPkmn)
					for (var i = 0; i < ds_list_size(pMoves); i++)
					{
						var moveName = ds_list_find_value(pMoves, i)
						var moveCurrentPP = ds_list_find_value(GetMovePPList(battle.playerPkmn), i)
						if (moveCurrentPP != 0)
						{
							struggle = false
							break
						}
					}
				}

				if (struggle)
				{
					var battle = instance_find(BattleObject, 0)
					var battleText = instance_create_layer(0,0,"UIElements",BattleTextboxObject)
					battleText.playerPkmn = battle.playerPkmn
					battleText.enemyPkmn = battle.enemyPkmn
					battleText.whoAttacked = "Player"
					var superEffStr = ""
					
					var pName = GetName(battle.playerPkmn)
					var pLevel = GetLevel(battle.playerPkmn)
					var pStatus = GetStatus(battle.playerPkmn)
					var playerStats = GetPokemonFinalStats(pName, pLevel)

					var eName = GetName(battle.enemyPkmn)
					var eLevel = GetLevel(battle.enemyPkmn)
					var eStatus = GetStatus(battle.enemyPkmn)
					var enemyStats = GetPokemonFinalStats(eName, eLevel)

					var pFutureStatus = "None"
					var eFutureStatus = "None"

					var playerMoveName = "Struggle"
					var moveName = playerMoveName
					var moveCurrentPP = 1

					if (moveCurrentPP > 0)
					{
						var enemyMoveName = ChooseMove(battle.enemyPkmn, battle.playerPkmn)

						var pPriority = GetMovePriority(playerMoveName)
						var ePriority = GetMovePriority(enemyMoveName)

						var pSpeedStat = GetSpeedStat(playerStats)
						if (pStatus == "Paralysis") pSpeedStat /= 2

						var eSpeedStat = GetSpeedStat(enemyStats)
						if (eStatus == "Paralysis") eSpeedStat /= 2

						if (pSpeedStat > eSpeedStat or pPriority > ePriority)
						{
							//Player Move
							var moveEff = GetMoveEffect(moveName)
							var damage = GetDamage(battle.playerPkmn, battle.enemyPkmn, moveName)
							var isCrit = RollCriticalChance(playerPkmn.critModifier)
							if (isCrit) damage *= 1.5
							battleText.playerMoveName = moveName
							battleText.playerDamage = damage

							if (damage > 0 and IsMoveSuperEffective(moveName, battle.enemyPkmn)) superEffStr = "It was super effective! "
							else if (damage > 0 and IsMoveNotVeryEffective(moveName, battle.enemyPkmn)) superEffStr = "It was not very effective! "

							var awake = true
							var paralysisCheck = true

								if (pStatus == "Paralysis")
								{
								    paralysisCheck = ParalysisCheck()
								}
							if ((pStatus == "Paralysis" and paralysisCheck))
							{
								var moveString = string_concat(GetName(battle.playerPkmn), " used ", moveName, ".")
								if (isCrit) moveString = string_concat(moveString, " It was a critical hit!")

								ConsumePP(battle.playerPkmn, currentOption)
								ds_list_add(battleText.textList, moveString)

								var moveAcc = GetMoveAccurancy(moveName)
								var effectAcc = GetMoveEffectChance(moveName)*100

								var accRoll = floor(random_range(0,101))
								if (accRoll <= moveAcc*0.95)
								{
									if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
									if (floor(random_range(0,101)) <= effectAcc)
									{
										if (IsStatusEffect(moveEff)) 
										{
											eFutureStatus = moveEff
											if (eFutureStatus == "RandomStatus")
											{
												var attempt = irandom(4)
												if (attempt == 1) eFutureStatus = "Paralysis"
												if (attempt == 2) eFutureStatus = "Poisoned"
												if (attempt == 3) eFutureStatus = "Burn"
												if (attempt == 4) eFutureStatus = "Sleep"
												moveEff = eFutureStatus
											}
										}
										var effStr = DealEffect(moveEff, effectAcc, damage, playerPkmn, enemyPkmn)
										if (effStr != "") ds_list_add(battleText.textList, effStr)
									}
								}
								else CauseAMiss(true)
							}
							else if (pStatus == "Paralysis" and !paralysisCheck)
							{
								ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " is paralyzed! It can't move!"))
							}
							else
							{
								if (pStatus == "Sleep" and playerPkmn.sleepCounter < 4) awake = WakeUpCheck()

								if (!awake)
								{
									ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " is asleep..."))
									playerPkmn.sleepCounter++
								}
								else
								{
									if (pStatus == "Sleep")
									{
										SetStatus(playerPkmn.pkmnInfo, "None")
										ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " woke up!"))
									}

									ConsumePP(battle.playerPkmn, currentOption)
									ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."))

									var moveAcc = GetMoveAccurancy(moveName)
									var effectAcc = GetMoveEffectChance(moveName)*100

									var accRoll = floor(random_range(0,101))
									if (accRoll <= moveAcc)
									{
										if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
										if (floor(random_range(0,101)) <= effectAcc)
										{
											if (IsStatusEffect(moveEff)) eFutureStatus = moveEff
											if (eFutureStatus == "RandomStatus")
											{
												var attempt = irandom(4)
												if (attempt == 1) eFutureStatus = "Paralysis"
												if (attempt == 2) eFutureStatus = "Poisoned"
												if (attempt == 3) eFutureStatus = "Burn"
												if (attempt == 4) eFutureStatus = "Sleep"
												moveEff = eFutureStatus
											}
											var effStr = DealEffect(moveEff, effectAcc, damage, playerPkmn, enemyPkmn)
											if (effStr != "") ds_list_add(battleText.textList, effStr)
										}
									}
									else CauseAMiss(true)
								}
							}

							if (((moveMissed or GetHealth(battle.enemyPkmn) > damage) or
							pStatus == "Paralysis" and !paralysisCheck) and awake)
							{
								struggle = true

								if (!ds_list_empty(optionsList))
								{
									var eMoves = GetMoves(battle.enemyPkmn)
									for (var i = 0; i < ds_list_size(eMoves); i++)
									{
										moveName = ds_list_find_value(eMoves, i)
										moveCurrentPP = ds_list_find_value(GetMovePPList(battle.enemyPkmn), i)
										if (moveCurrentPP != 0)
										{
											struggle = false
											break
										}
									}
								}

								//Enemy Move
								if (!struggle) moveName = enemyMoveName
								else moveName = "Struggle"

								moveEff = GetMoveEffect(moveName)
								damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
								isCrit = RollCriticalChance(enemyPkmn.critModifier)
								if (isCrit) damage *= 1.5
								battleText.enemyMoveName = moveName
								battleText.enemyDamage = damage

								superEffStr = ""
								if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
								else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "

								awake = true
								paralysisCheck = ParalysisCheck()
								if ((eStatus == "Paralysis" and paralysisCheck) or
								(eFutureStatus == "Paralysis" and paralysisCheck))
								{
									var moveString = string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName)
									if (isCrit) moveString = string_concat(moveString, " It was a critical hit!")

									ConsumePP(battle.enemyPkmn, ds_list_find_index(GetMoves(battle.enemyPkmn), moveName))
									ds_list_add(battleText.textList, moveString)

									var moveAcc = GetMoveAccurancy(moveName)
									var effectAcc = GetMoveEffectChance(moveName)*100
									if (floor(random_range(0,101)) <= moveAcc*0.95)
									{
										if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
										if (floor(random_range(0,101)) <= effectAcc)
										{
											var effStr = DealEffect(moveEff, effectAcc, damage, enemyPkmn, playerPkmn)
											if (effStr != "") ds_list_add(battleText.textList, effStr)
										}
									}
									else CauseAMiss(false)

									if (GetHealth(battle.playerPkmn) <= 0) ds_list_add(battleText.textList,
										string_concat(GetName(battle.playerPkmn)," fainted!"))
								}
								else if ((eStatus == "Paralysis" and !paralysisCheck) or
								(eFutureStatus == "Paralysis" and !paralysisCheck))
								{
									ds_list_add(battleText.textList, string_concat("The foe's ", GetName(battle.enemyPkmn), " is paralyzed! It can't move!"))
								}
								else
								{
									if (eStatus == "Sleep" and enemyPkmn.sleepCounter < 4) or
									(eFutureStatus == "Sleep" and enemyPkmn.sleepCounter < 4) awake = WakeUpCheck()
									if (GetMoveEffect(playerMoveName) == "Sleep" and (!moveMissed and pStatus != "Sleep") and eStatus == "None") awake = false

									if (!awake)
									{
										ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " is asleep..."))
										enemyPkmn.sleepCounter++
									}
									else
									{
										if (eStatus == "Sleep" or eFutureStatus == "Sleep")
										{
											SetStatus(enemyPkmn.pkmnInfo, "None")
											ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " woke up!"))
										}

										ConsumePP(battle.enemyPkmn, ds_list_find_index(GetMoves(battle.enemyPkmn), moveName))
										ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName))

										var moveAcc = GetMoveAccurancy(moveName)
										var effectAcc = GetMoveEffectChance(moveName)*100
										if (floor(random_range(0,101)) <= moveAcc)
										{
											if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
											if (floor(random_range(0,101)) <= effectAcc)
											{
												if (IsStatusEffect(moveEff)) pFutureStatus = moveEff
												if (pFutureStatus == "RandomStatus")
												{
													var attempt = irandom(4)
													if (attempt == 1) pFutureStatus = "Paralysis"
													if (attempt == 2) pFutureStatus = "Poisoned"
													if (attempt == 3) pFutureStatus = "Burn"
													if (attempt == 4) pFutureStatus = "Sleep"
													moveEff = pFutureStatus
												}
												var effStr = DealEffect(moveEff, effectAcc, damage, enemyPkmn, playerPkmn)
												if (effStr != "") ds_list_add(battleText.textList, effStr)
											}
										}
										else CauseAMiss(false)

										if (GetHealth(battle.playerPkmn) <= 0) ds_list_add(battleText.textList,
										string_concat(GetName(battle.playerPkmn)," fainted!"))
									}
								}

								if (pStatus == "Poisoned" or (GetMoveEffect(enemyMoveName) == "Poisoned" and pStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took poison damage")
								if (eStatus == "Poisoned" or (GetMoveEffect(playerMoveName) == "Poisoned" and eStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took poison damage")

								if (pStatus == "Burn" or (GetMoveEffect(enemyMoveName) == "Burn" and pStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took burn damage")
								if (eStatus == "Burn" or (GetMoveEffect(playerMoveName) == "Burn" and eStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took burn damage")
							}
							else
							{
								if (pStatus == "Poisoned" or (GetMoveEffect(enemyMoveName) == "Poisoned" and pStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took poison damage")
								if (pStatus == "Burn" or (GetMoveEffect(playerMoveName) == "Burn" and eStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took burn damage")
							}
						}
						else if (eSpeedStat > pSpeedStat or ePriority > pPriority)
						{
							struggle = true

							if (!ds_list_empty(optionsList))
							{
								battle = instance_find(BattleObject, 0)
								var eMoves = GetMoves(battle.enemyPkmn)
								for (var i = 0; i < ds_list_size(eMoves); i++)
								{
									moveName = ds_list_find_value(eMoves, i)
									moveCurrentPP = ds_list_find_value(GetMovePPList(battle.enemyPkmn), i)
									if (moveCurrentPP != 0)
									{
										struggle = false
										break
									}
								}
							}

							if (!struggle) moveName = enemyMoveName
							else moveName = "Struggle"
							
							var moveEff = GetMoveEffect(moveName)
							var damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
							var isCrit = RollCriticalChance(enemyPkmn.critModifier)
							if (isCrit) damage *= 1.5
							battleText.enemyMoveName = moveName
							battleText.enemyDamage = damage

							if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
							else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "

							var awake = true
							var paralysisCheck = true

							if (eStatus == "Paralysis")
								{
								    paralysisCheck = ParalysisCheck()
								}
							if ((eStatus == "Paralysis" and paralysisCheck))
							{
								var moveString = string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName, ".")
								if (isCrit) moveString = string_concat(moveString, " It was a critical hit!")

								ConsumePP(battle.enemyPkmn, ds_list_find_index(GetMoves(battle.enemyPkmn), moveName))
								ds_list_add(battleText.textList, moveString)

								var moveAcc = GetMoveAccurancy(moveName)
								var effectAcc = GetMoveEffectChance(moveName)*100
								if (floor(random_range(0,101)) <= moveAcc*0.95)
								{
									if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
									if (floor(random_range(0,101)) <= effectAcc)
									{
										if (IsStatusEffect(moveEff)) pFutureStatus = moveEff
										if (pFutureStatus == "RandomStatus")
										{
											var attempt = irandom(4)
											if (attempt == 1) pFutureStatus = "Paralysis"
											if (attempt == 2) pFutureStatus = "Poisoned"
											if (attempt == 3) pFutureStatus = "Burn"
											if (attempt == 4) pFutureStatus = "Sleep"
											moveEff = pFutureStatus
										}
										var effStr = DealEffect(moveEff, effectAcc, damage, enemyPkmn, playerPkmn)
										if (effStr != "") ds_list_add(battleText.textList, effStr)
									}
								}
								else CauseAMiss(false)
							}
							else if (eStatus == "Paralysis" and !paralysisCheck)
							{
								ds_list_add(battleText.textList, string_concat("The foe's ", GetName(battle.enemyPkmn), " is paralyzed! It can't move!"))
							}
							else
							{
								if (pStatus == "Sleep" and enemyPkmn.sleepCounter < 4) awake = WakeUpCheck()

								if (!awake)
								{
									ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " is asleep..."))
									enemyPkmn.sleepCounter++
								}
								else
								{
									if (eStatus == "Sleep")
									{
										SetStatus(enemyPkmn.pkmnInfo, "None")
										ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " woke up!"))
									}

									ConsumePP(battle.enemyPkmn, ds_list_find_index(GetMoves(battle.enemyPkmn), moveName))
									ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName, "."))

									var moveAcc = GetMoveAccurancy(moveName)
									var effectAcc = GetMoveEffectChance(moveName)*100
									if (floor(random_range(0,101)) <= moveAcc)
									{
										if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
										if (floor(random_range(0,101)) <= effectAcc)
										{
											if (IsStatusEffect(moveEff)) pFutureStatus = moveEff
											if (pFutureStatus == "RandomStatus")
											{
												var attempt = irandom(4)
												if (attempt == 1) pFutureStatus = "Paralysis"
												if (attempt == 2) pFutureStatus = "Poisoned"
												if (attempt == 3) pFutureStatus = "Burn"
												if (attempt == 4) pFutureStatus = "Sleep"
												moveEff = pFutureStatus
											}
											var effStr = DealEffect(moveEff, effectAcc, damage, enemyPkmn, playerPkmn)
											if (effStr != "") ds_list_add(battleText.textList, effStr)
										}
									}
									else CauseAMiss(false)
								}
							}

							if (((moveMissed or GetHealth(battle.playerPkmn) > damage) or
							eStatus == "Paralysis" and !paralysisCheck) and awake)
							{
								struggle = true

								if (!ds_list_empty(optionsList))
								{
									battle = instance_find(BattleObject, 0)
									var pMoves = GetMoves(battle.playerPkmn)
									for (var i = 0; i < ds_list_size(pMoves); i++)
									{
										moveName = ds_list_find_value(pMoves, i)
										moveCurrentPP = ds_list_find_value(GetMovePPList(battle.playerPkmn), i)
										if (moveCurrentPP != 0)
										{
											struggle = false
											break
										}
									}
								}

								//Player Move
								if (!struggle) moveName = playerMoveName
								else moveName = "Struggle"

								moveEff = GetMoveEffect(moveName)
								damage = GetDamage(battle.playerPkmn, battle.enemyPkmn, moveName)
								isCrit = RollCriticalChance(playerPkmn.critModifier)
								if (isCrit) damage *= 1.5
								battleText.moveName = moveName
								battleText.playerMoveName = moveName
								battleText.playerDamage = damage

								superEffStr = ""
								if (IsMoveSuperEffective(moveName, battle.enemyPkmn)) superEffStr = "It was super effective! "
								else if (IsMoveNotVeryEffective(moveName, battle.enemyPkmn)) superEffStr = "It was not very effective! "

								awake = true
								paralysisCheck = ParalysisCheck()
								if ((pStatus == "Paralysis" and paralysisCheck) or
								(pFutureStatus == "Paralysis" and paralysisCheck))
								{
									var moveString = string_concat(GetName(battle.playerPkmn), " used ", moveName, ".")
									if (isCrit) moveString = string_concat(moveString, " It was a critical hit!")

									ConsumePP(battle.playerPkmn, currentOption)
									ds_list_add(battleText.textList, moveString)

									var moveAcc = GetMoveAccurancy(moveName)
									var effectAcc = GetMoveEffectChance(moveName)*100
									if (floor(random_range(0,101)) <= moveAcc*0.95)
									{
										if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
										if (floor(random_range(0,101)) <= effectAcc)
										{
											if (IsStatusEffect(moveEff)) eFutureStatus = moveEff
											if (pFutureStatus == "RandomStatus")
											{
												var attempt = irandom(4)
												if (attempt == 1) eFutureStatus = "Paralysis"
												if (attempt == 2) eFutureStatus = "Poisoned"
												if (attempt == 3) eFutureStatus = "Burn"
												if (attempt == 4) eFutureStatus = "Sleep"
												moveEff = eFutureStatus
											}
											var effStr = DealEffect(moveEff, effectAcc, damage, playerPkmn, enemyPkmn)
											if (effStr != "") ds_list_add(battleText.textList, effStr)
										}
									}
									else CauseAMiss(true)

									if (GetHealth(battle.enemyPkmn) <= 0) ds_list_add(battleText.textList,
									string_concat("The opposing ", GetName(battle.enemyPkmn)," fainted!"))
								}
								else if ((pStatus == "Paralysis" and !paralysisCheck) or
								(pFutureStatus == "Paralysis" and !paralysisCheck))
								{
									ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " is paralyzed! It can't move!"))
								}
								else
								{
									if ((pStatus == "Sleep" and playerPkmn.sleepCounter < 4) or
									(pFutureStatus == "Sleep" and playerPkmn.sleepCounter < 4)) awake = WakeUpCheck()
									if (GetMoveEffect(enemyMoveName) == "Sleep" and (!moveMissed and eStatus != "Sleep") and pStatus == "None") awake = false

									if (!awake)
									{
										ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " is asleep..."))
										playerPkmn.sleepCounter++
									}
									else
									{
										if (pStatus == "Sleep" or pFutureStatus == "Sleep")
										{
											SetStatus(playerPkmn.pkmnInfo, "None")
											ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " woke up!"))
										}

										ConsumePP(battle.playerPkmn, currentOption)
										ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."),)

									    var moveAcc = GetMoveAccurancy(moveName)
										var effectAcc = GetMoveEffectChance(moveName)*100
										if (floor(random_range(0,101)) <= moveAcc)
										{
											if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
											if (floor(random_range(0,101)) <= effectAcc)
											{
												if (IsStatusEffect(moveEff)) eFutureStatus = moveEff
												if (pFutureStatus == "RandomStatus")
												{
													var attempt = irandom(4)
													if (attempt == 1) eFutureStatus = "Paralysis"
													if (attempt == 2) eFutureStatus = "Poisoned"
													if (attempt == 3) eFutureStatus = "Burn"
													if (attempt == 4) eFutureStatus = "Sleep"
													moveEff = eFutureStatus
												}
												var effStr = DealEffect(moveEff, effectAcc, damage, playerPkmn, enemyPkmn)
												if (effStr != "") ds_list_add(battleText.textList, effStr)
											}
										}
										else CauseAMiss(true)

										if (GetHealth(battle.enemyPkmn) <= 0) ds_list_add(battleText.textList,
										string_concat("The opposing ", GetName(battle.enemyPkmn)," fainted!"))
									}
								}

								if (eStatus == "Poisoned" or (GetMoveEffect(enemyMoveName) == "Poisoned" and pStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took poison damage")
								if (pStatus == "Poisoned" or (GetMoveEffect(playerMoveName) == "Poisoned" and eStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took poison damage")

								if (eStatus == "Burn" or (GetMoveEffect(enemyMoveName) == "Burn" and pStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took burn damage")
								if (pStatus == "Burn" or (GetMoveEffect(playerMoveName) == "Burn" and eStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took burn damage")
							}
							else
							{
								if (pStatus == "Poisoned" or (GetMoveEffect(enemyMoveName) == "Poisoned" and pStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took poison damage")
								if (pStatus == "Burn" or (GetMoveEffect(playerMoveName) == "Burn" and eStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took burn damage")
							}
						}
						instance_destroy(id)
					}
				}
				else mode = "Moves"
				break
			case 1:
				var bag = instance_create_layer(x,y,layer,BagMenuObject)
				bag.menu = id
				bag.battle = true
				mode = "Bag"
				break
			case 2:
				var pkmnMenu = instance_create_layer(x,y,layer,PokemonMenuObject)
				pkmnMenu.menu = id
				pkmnMenu.battleSwitchMode = true
				mode = "Switch"
				break
			case 3:
				var battleText = instance_create_layer(0,0,"UIElements",BattleTextboxObject)
				var battle = instance_find(BattleObject, 0)
				if (!battle.isWild)
				{
					for (var i = 0; i < ds_list_size(battle.playerTeam); i++)
					{
						var pkmnInfo = ds_list_find_value(battle.playerTeam, i)
						if (GetHealth(pkmnInfo) > 0) ds_list_set(pkmnInfo, 5, 0)
					}

					var activePkmn = FindBattlePokemonEntity(battle.playerPkmn)
					if (activePkmn != noone)
					{
						activePkmn.hp = 0
						ds_list_set(activePkmn.pkmnInfo, 5, 0)
					}

					ds_list_add(battleText.textList, "You gave up!", "You lose!")
					battleText.endBattle = true
					battleText.defeat = true
				}
				else
				{
					var canRun = TryToRun(battle.playerPkmn, battle.enemyPkmn, battle.runAttempts)
					if (canRun)
					{
						ds_list_add(battleText.textList, "You ran away!")
						battleText.endBattle = true
						battle.escaped = true
					}
					else
					{
						ds_list_add(battleText.textList, "You couldn't run!")
						battle.runAttempts++

						battleText.playerPkmn = battle.playerPkmn
						battleText.enemyPkmn = battle.enemyPkmn
						battleText.whoAttacked = "Player"
						var superEffStr = ""

						var pFutureStatus = "None"
						var eFutureStatus = "None"
						
						var pName = GetName(battle.playerPkmn)
						var pLevel = GetLevel(battle.playerPkmn)
						var playerStats = GetPokemonFinalStats(pName, pLevel)

						var eName = GetName(battle.enemyPkmn)
						var eLevel = GetLevel(battle.enemyPkmn)
						var enemyStats = GetPokemonFinalStats(eName, eLevel)
					
						var enemyMoveName = ChooseMove(battle.enemyPkmn, battle.playerPkmn)
						var moveName = enemyMoveName
						var moveEff = GetMoveEffect(moveName)
						var damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
						battleText.enemyMoveName = moveName
						battleText.enemyDamage = damage

						if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
						else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "

						ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName, "."))

						var moveAcc = GetMoveAccurancy(moveName)
						var effectAcc = GetMoveEffectChance(moveName)*100
						if (floor(random_range(0,101)) <= moveAcc)
						{
							if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
							if (floor(random_range(0,101)) <= effectAcc)
							{
								if (IsStatusEffect(moveEff)) pFutureStatus = moveEff
								if (pFutureStatus == "RandomStatus")
								{
									var attempt = irandom(3)
									if (attempt == 0) pFutureStatus = "Paralysis"
									if (attempt == 1) pFutureStatus = "Poisoned"
									if (attempt == 2) pFutureStatus = "Burn"
									if (attempt == 3) pFutureStatus = "Sleep"
									moveEff = pFutureStatus
								}
								var effStr = DealEffect(moveEff, effectAcc, damage, enemyPkmn, playerPkmn)
								if (effStr != "") ds_list_add(battleText.textList, effStr)
							}
						}
						else CauseAMiss(false)
					}
				}
				instance_destroy(id)
				break
		}
	}
	else if (mode == "Moves" and ds_list_find_value(GetMoves(BattleObject.playerPkmn), currentOption) != undefined)
	{
		var playerPkmnBattle = -4
		var enemyPkmnBattle = -4
		
		for (var i = 0; i < instance_number(BattlePokemonObject); i++)
		{
			var pkmn = instance_find(BattlePokemonObject, i)
			if (pkmn.playerTeam) playerPkmnBattle = pkmn
			else enemyPkmnBattle = pkmn
		}
		
		var battle = instance_find(BattleObject, 0)
		var playerMoveName = ds_list_find_value(GetMoves(battle.playerPkmn), currentOption)
		var moveName = playerMoveName
		var moveTotalPP = GetMovePP(moveName)
		var moveCurrentPP = (ds_list_find_value(GetMovePPList(battle.playerPkmn), currentOption))

		if (moveCurrentPP > 0)
		{
			var battleText = instance_create_layer(0,0,"UIElements",BattleTextboxObject)
			battleText.playerPkmn = battle.playerPkmn
			battleText.enemyPkmn = battle.enemyPkmn
			battleText.whoAttacked = "Player"
			var superEffStr = ""
			
			var pFutureStatus = "None"
			var eFutureStatus = "None"

			var pName = GetName(battle.playerPkmn)
			var pLevel = GetLevel(battle.playerPkmn)
			var pStatus = GetStatus(battle.playerPkmn)
			var playerStats = GetPokemonFinalStats(pName, pLevel)

			var eName = GetName(battle.enemyPkmn)
			var eLevel = GetLevel(battle.enemyPkmn)
			var eStatus = GetStatus(battle.enemyPkmn)
			var enemyStats = GetPokemonFinalStats(eName, eLevel)

			var enemyMoveName = ChooseMove(battle.enemyPkmn, battle.playerPkmn)

			var pPriority = GetMovePriority(playerMoveName)
			var ePriority = GetMovePriority(enemyMoveName)

			var pSpeedStat = GetSpeedStat(playerStats)
			if (pStatus == "Paralysis") pSpeedStat /= 2

			var eSpeedStat = GetSpeedStat(enemyStats)
			if (eStatus == "Paralysis") eSpeedStat /= 2

			if (pSpeedStat == eSpeedStat)
			{
				var tieBreaker = irandom(1)
				if (tieBreaker > 0) pSpeedStat++
				else eSpeedStat++
			}
			
			if (pSpeedStat > eSpeedStat or pPriority > ePriority)
			{
				//Player Move
				var awake = true
				var skipTurn = false
				var moveEff = GetMoveEffect(moveName)
				var damage = GetDamage(battle.playerPkmn, battle.enemyPkmn, moveName)
				battleText.playerMoveName = moveName
				battleText.playerDamage = damage

				if (damage > 0 and IsMoveSuperEffective(moveName, battle.enemyPkmn)) superEffStr = "It was super effective! "
				else if (damage > 0 and IsMoveNotVeryEffective(moveName, battle.enemyPkmn)) superEffStr = "It was not very effective! "
				
				if (moveName == "Convince" or moveName == "Logic") global.convinceCounter++
				else global.convinceCounter = 0
				var convincedCheck = ConvinceCheck()
				
				var paralysisCheck = true

				if (pStatus == "Paralysis")
				{
				    paralysisCheck = ParalysisCheck()
				}
				if ((pStatus == "Paralysis" and paralysisCheck))
				{
					if (IsNotConfused(playerPkmnBattle))
					{
						ConsumePP(battle.playerPkmn, currentOption)
						ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."))

						var moveAcc = GetMoveAccurancy(moveName)
						var effectAcc = GetMoveEffectChance(moveName)*100

						var accRoll = floor(random_range(0,101))
						if (accRoll <= moveAcc)
						{
							if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
						
							if (IsStatusEffect(moveEff)) eFutureStatus = moveEff
							if (eFutureStatus == "RandomStatus")
							{
								var attempt = irandom(3)
								if (attempt == 0) eFutureStatus = "Paralysis"
								if (attempt == 1) eFutureStatus = "Poisoned"
								if (attempt == 2) eFutureStatus = "Burn"
								if (attempt == 3) eFutureStatus = "Sleep"
								moveEff = eFutureStatus
							}
							var effStr = DealEffect(moveEff, effectAcc, damage, playerPkmn, enemyPkmn)
							if (effStr != "") ds_list_add(battleText.textList, effStr)
						}
						else CauseAMiss(true)
					}
				}
				else if (pStatus == "Paralysis" and !paralysisCheck)
				{
					ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " is paralyzed! It can't move!"))
				}
				else
				{
					if (pStatus == "Sleep" and playerPkmn.sleepCounter < 4) awake = WakeUpCheck()

					if (!awake)
					{
						ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " is asleep..."))
						playerPkmn.sleepCounter++
					}
					else
					{
						if (pStatus == "Sleep")
						{
							SetStatus(playerPkmn.pkmnInfo, "None")
							ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " woke up!"))
						}
						
						if (IsNotConfused(playerPkmnBattle))
						{
							ConsumePP(battle.playerPkmn, currentOption)
							ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."))

							var moveAcc = GetMoveAccurancy(moveName)
							var effectAcc = GetMoveEffectChance(moveName)*100

							var accRoll = floor(random_range(0,101))
							if (accRoll <= moveAcc)
							{
								if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
							
								if (IsStatusEffect(moveEff)) eFutureStatus = moveEff
								if (eFutureStatus == "RandomStatus")
								{
									var attempt = irandom(3)
									if (attempt == 0) eFutureStatus = "Paralysis"
									if (attempt == 1) eFutureStatus = "Poisoned"
									if (attempt == 2) eFutureStatus = "Burn"
									if (attempt == 3) eFutureStatus = "Sleep"
									moveEff = eFutureStatus
								}
								var effStr = DealEffect(moveEff, effectAcc, damage, playerPkmn, enemyPkmn)
								if (effStr != "") ds_list_add(battleText.textList, effStr)
							}
							else CauseAMiss(true)
						}
					}
				}
				
				if ((moveMissed or ((GetHealth(battle.enemyPkmn) > damage and awake and paralysisCheck and !skipTurn) or !awake)))
				{
					if (convincedCheck)
					{
						moveName = enemyMoveName
						moveEff = GetMoveEffect(moveName)
						damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
						battleText.enemyMoveName = moveName
						battleText.enemyDamage = damage
						
						ds_list_add(battleText.textList, "The opponent was convinced not to attack!")
						
						if (pStatus == "Poisoned" or (GetMoveEffect(enemyMoveName) == "Poisoned" and pStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took poison damage")
						if (eStatus == "Poisoned" or (GetMoveEffect(playerMoveName) == "Poisoned" and eStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took poison damage")

						if (pStatus == "Burn" or (GetMoveEffect(enemyMoveName) == "Burn" and pStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took burn damage")
						if (eStatus == "Burn" or (GetMoveEffect(playerMoveName) == "Burn" and eStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took burn damage")
					}
					else
					{
						if (moveName == "Convince" or moveName == "Logic")
						{
							ds_list_add(battleText.textList, "The foe's Pokémon was not convinced!")
						}
						
						//Enemy Move
						awake = true
						moveName = enemyMoveName
						moveEff = GetMoveEffect(moveName)
						damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
						battleText.enemyMoveName = moveName
						battleText.enemyDamage = damage

						superEffStr = ""
						if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
						else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "

						paralysisCheck = ParalysisCheck()
						if ((eStatus == "Paralysis" and paralysisCheck))
						{
							if (IsNotConfused(enemyPkmnBattle))
							{
								ConsumePP(battle.enemyPkmn, ds_list_find_index(GetMoves(battle.enemyPkmn), moveName))
								ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName))

								var moveAcc = GetMoveAccurancy(moveName)
								var effectAcc = GetMoveEffectChance(moveName)*100
								if (floor(random_range(0,101)) <= moveAcc)
								{
									if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))

									if (IsStatusEffect(moveEff)) pFutureStatus = moveEff
									if (pFutureStatus == "RandomStatus")
									{
										var attempt = irandom(3)
										if (attempt == 0) pFutureStatus = "Paralysis"
										if (attempt == 1) pFutureStatus = "Poisoned"
										if (attempt == 2) pFutureStatus = "Burn"
										if (attempt == 3) pFutureStatus = "Sleep"
										moveEff = pFutureStatus
									}
									var effStr = DealEffect(moveEff, effectAcc, damage, enemyPkmn, playerPkmn)
									if (effStr != "") ds_list_add(battleText.textList, effStr)
								}
								else CauseAMiss(false)

								if (GetHealth(battle.playerPkmn) <= 0) ds_list_add(battleText.textList,
									string_concat(GetName(battle.playerPkmn)," fainted!"))
							}
						}
						else if (eStatus == "Paralysis" and !paralysisCheck)
						{
							ds_list_add(battleText.textList, string_concat("The foe's ", GetName(battle.enemyPkmn), " is paralyzed! It can't move!"))
						}
						else
						{
							if (eStatus == "Sleep" and enemyPkmn.sleepCounter < 4) awake = WakeUpCheck()
							if (GetMoveEffect(playerMoveName) == "Sleep" and (!moveMissed and pStatus != "Sleep") and eStatus == "None") awake = false

							if (!awake)
							{
								ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " is asleep..."))
								enemyPkmn.sleepCounter++
							}
							else
							{
								if (eStatus == "Sleep")
								{
									SetStatus(enemyPkmn.pkmnInfo, "None")
									ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " woke up!"))
								}
								
								if (IsNotConfused(enemyPkmnBattle))
								{
									ConsumePP(battle.enemyPkmn, ds_list_find_index(GetMoves(battle.enemyPkmn), moveName))
									ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName))

									var moveAcc = GetMoveAccurancy(moveName)
									var effectAcc = GetMoveEffectChance(moveName)*100
									if (floor(random_range(0,101)) <= moveAcc)
									{
										if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
									
										if (IsStatusEffect(moveEff)) pFutureStatus = moveEff
										if (pFutureStatus == "RandomStatus")
										{
											var attempt = irandom(3)
											if (attempt == 0) pFutureStatus = "Paralysis"
											if (attempt == 1) pFutureStatus = "Poisoned"
											if (attempt == 2) pFutureStatus = "Burn"
											if (attempt == 3) pFutureStatus = "Sleep"
											moveEff = pFutureStatus
										}
										var effStr = DealEffect(moveEff, effectAcc, damage, enemyPkmn, playerPkmn)
										if (effStr != "") ds_list_add(battleText.textList, effStr)
									}
									else CauseAMiss(false)

									if (GetHealth(battle.playerPkmn) <= 0) ds_list_add(battleText.textList,
									string_concat(GetName(battle.playerPkmn)," fainted!"))
								}
							}
						}
					
						if (pStatus == "Poisoned" or (GetMoveEffect(enemyMoveName) == "Poisoned" and pStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took poison damage")
						if (eStatus == "Poisoned" or (GetMoveEffect(playerMoveName) == "Poisoned" and eStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took poison damage")

						if (pStatus == "Burn" or (GetMoveEffect(enemyMoveName) == "Burn" and pStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took burn damage")
						if (eStatus == "Burn" or (GetMoveEffect(playerMoveName) == "Burn" and eStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took burn damage")
					}
				}
			}
			else if (eSpeedStat > pSpeedStat or ePriority > pPriority)
			{
				var awake = true
				var skipTurn = false
				moveName = enemyMoveName
				var moveEff = GetMoveEffect(moveName)
				var damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
				battleText.enemyMoveName = moveName
				battleText.enemyDamage = damage

				if (damage > 0 and IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
				else if (damage > 0 and IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "
				
				if (moveName == "Convince" or moveName == "Logic") global.convinceCounter++
				else global.convinceCounter = 0
				var convincedCheck = ConvinceCheck()
				
				var paralysisCheck = true

				if (eStatus == "Paralysis")
					{
					    paralysisCheck = ParalysisCheck()
					}
				if ((eStatus == "Paralysis" and paralysisCheck))
				{
					if (IsNotConfused(enemyPkmnBattle))
					{
						ConsumePP(battle.enemyPkmn, ds_list_find_index(GetMoves(battle.enemyPkmn), moveName))
						ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName, "."))

						var moveAcc = GetMoveAccurancy(moveName)
						var effectAcc = GetMoveEffectChance(moveName)*100
						if (floor(random_range(0,101)) <= moveAcc)
						{
							if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))

							if (IsStatusEffect(moveEff)) pFutureStatus = moveEff
							if (pFutureStatus == "RandomStatus")
							{
								var attempt = irandom(3)
								if (attempt == 0) pFutureStatus = "Paralysis"
								if (attempt == 1) pFutureStatus = "Poisoned"
								if (attempt == 2) pFutureStatus = "Burn"
								if (attempt == 3) pFutureStatus = "Sleep"
								moveEff = pFutureStatus
							}
							var effStr = DealEffect(moveEff, effectAcc, damage, enemyPkmn, playerPkmn)
							if (effStr != "") ds_list_add(battleText.textList, effStr)
						}
						else CauseAMiss(false)
					}
				}
				else if (eStatus == "Paralysis" and !paralysisCheck)
				{
					ds_list_add(battleText.textList, string_concat("The foe's ", GetName(battle.enemyPkmn), " is paralyzed! It can't move!"))
				}
				else
				{
					if (eStatus == "Sleep" and enemyPkmn.sleepCounter < 4) awake = WakeUpCheck()

					if (!awake)
					{
						ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " is asleep..."))
						enemyPkmn.sleepCounter++
					}
					else
					{
						if (eStatus == "Sleep")
						{
							SetStatus(enemyPkmn.pkmnInfo, "None")
							ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " woke up!"))
						}
						
						if (IsNotConfused(enemyPkmnBattle))
						{
							ConsumePP(battle.enemyPkmn, ds_list_find_index(GetMoves(battle.enemyPkmn), moveName))
							ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName, "."))

							var moveAcc = GetMoveAccurancy(moveName)
							var effectAcc = GetMoveEffectChance(moveName)*100
							if (floor(random_range(0,101)) <= moveAcc)
							{
								if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
							
								if (IsStatusEffect(moveEff)) pFutureStatus = moveEff
								if (pFutureStatus == "RandomStatus")
								{
									var attempt = irandom(3)
									if (attempt == 0) pFutureStatus = "Paralysis"
									if (attempt == 1) pFutureStatus = "Poisoned"
									if (attempt == 2) pFutureStatus = "Burn"
									if (attempt == 3) pFutureStatus = "Sleep"
									moveEff = pFutureStatus
								}
								var effStr = DealEffect(moveEff, effectAcc, damage, enemyPkmn, playerPkmn)
								if (effStr != "") ds_list_add(battleText.textList, effStr)
							}
							else CauseAMiss(false)
						}
					}
				}

				if (moveMissed or ((GetHealth(battle.playerPkmn) > damage and awake and paralysisCheck and !skipTurn) or !awake)) //and paralysisCheck and awake
				{
					if (convincedCheck)
					{
						moveName = playerMoveName
						moveEff = GetMoveEffect(moveName)
						battleText.moveName = moveName
						battleText.playerMoveName = moveName
						battleText.playerDamage = damage
						
						ds_list_add(battleText.textList, "Your pokémon was convinced not to attack!")
						
						if (eStatus == "Poisoned" or (GetMoveEffect(enemyMoveName) == "Poisoned" and pStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took poison damage")
						if (pStatus == "Poisoned" or (GetMoveEffect(playerMoveName) == "Poisoned" and eStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took poison damage")

						if (eStatus == "Burn" or (GetMoveEffect(enemyMoveName) == "Burn" and pStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took burn damage")
						if (pStatus == "Burn" or (GetMoveEffect(playerMoveName) == "Burn" and eStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took burn damage")
					}
					else
					{
						if (moveName == "Convince" or moveName == "Logic")
						{
							ds_list_add(battleText.textList, "Your Pokémon was not convinced!")
						}
						
						//Player Move
						awake = true
						moveName = playerMoveName
						moveEff = GetMoveEffect(moveName)
						damage = GetDamage(battle.playerPkmn, battle.enemyPkmn, moveName)
						battleText.moveName = moveName
						battleText.playerMoveName = moveName
						battleText.playerDamage = damage

						superEffStr = ""
						if (IsMoveSuperEffective(moveName, battle.enemyPkmn)) superEffStr = "It was super effective! "
						else if (IsMoveNotVeryEffective(moveName, battle.enemyPkmn)) superEffStr = "It was not very effective! "

						paralysisCheck = ParalysisCheck()
						if ((pStatus == "Paralysis" and paralysisCheck))
						{
							if (IsNotConfused(playerPkmnBattle))
							{
								ConsumePP(battle.playerPkmn, currentOption)
								ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."),)

								var moveAcc = GetMoveAccurancy(moveName)
								var effectAcc = GetMoveEffectChance(moveName)*100
								if (floor(random_range(0,101)) <= moveAcc)
								{
									if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))

									if (IsStatusEffect(moveEff)) eFutureStatus = moveEff
									if (eFutureStatus == "RandomStatus")
									{
										var attempt = irandom(3)
										if (attempt == 0) eFutureStatus = "Paralysis"
										if (attempt == 1) eFutureStatus = "Poisoned"
										if (attempt == 2) eFutureStatus = "Burn"
										if (attempt == 3) eFutureStatus = "Sleep"
										moveEff = eFutureStatus
									}
									var effStr = DealEffect(moveEff, effectAcc, damage, playerPkmn, enemyPkmn)
									if (effStr != "") ds_list_add(battleText.textList, effStr)
								}
								else CauseAMiss(true)

								if (GetHealth(battle.enemyPkmn) <= 0) ds_list_add(battleText.textList,
								string_concat("The opposing ", GetName(battle.enemyPkmn)," fainted!"))
							}
						}
						else if (pStatus == "Paralysis" and !paralysisCheck)
						{
							ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " is paralyzed! It can't move!"))
						}
						else
						{
							if (pStatus == "Sleep" and playerPkmn.sleepCounter < 4) awake = WakeUpCheck()
							if (GetMoveEffect(enemyMoveName) == "Sleep" and (!moveMissed and eStatus != "Sleep") and pStatus == "None") awake = false

							if (!awake)
							{
								ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " is asleep..."))
								playerPkmn.sleepCounter++
							}
							else
							{
								if (pStatus == "Sleep")
								{
									SetStatus(playerPkmn.pkmnInfo, "None")
									ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " woke up!"))
								}
								
								if (IsNotConfused(playerPkmnBattle))
								{
									ConsumePP(battle.playerPkmn, currentOption)
									ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."),)

								    var moveAcc = GetMoveAccurancy(moveName)
									var effectAcc = GetMoveEffectChance(moveName)*100
									if (floor(random_range(0,101)) <= moveAcc)
									{
										if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))

										if (IsStatusEffect(moveEff)) eFutureStatus = moveEff
										if (eFutureStatus == "RandomStatus")
										{
											var attempt = irandom(3)
											if (attempt == 0) eFutureStatus = "Paralysis"
											if (attempt == 1) eFutureStatus = "Poisoned"
											if (attempt == 2) eFutureStatus = "Burn"
											if (attempt == 3) eFutureStatus = "Sleep"
											moveEff = eFutureStatus
										}
										var effStr = DealEffect(moveEff, effectAcc, damage, playerPkmn, enemyPkmn)
										if (effStr != "") ds_list_add(battleText.textList, effStr)
									}
									else CauseAMiss(true)

									if (GetHealth(battle.enemyPkmn) <= 0) ds_list_add(battleText.textList,
									string_concat("The opposing ", GetName(battle.enemyPkmn)," fainted!"))
								}
							}
						}

						if (eStatus == "Poisoned" or (GetMoveEffect(enemyMoveName) == "Poisoned" and pStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took poison damage")
						if (pStatus == "Poisoned" or (GetMoveEffect(playerMoveName) == "Poisoned" and eStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took poison damage")

						if (eStatus == "Burn" or (GetMoveEffect(enemyMoveName) == "Burn" and pStatus == "None")) ds_list_add(battleText.textList, "The opponent's pokemon took burn damage")
						if (pStatus == "Burn" or (GetMoveEffect(playerMoveName) == "Burn" and eStatus == "None")) ds_list_add(battleText.textList, "Your pokemon took burn damage")
					}
				}
			}
			
			instance_destroy(id)
		}
	}
}

if (mode == "Choosing" or mode == "Moves")
{
	if (keyboard_check_pressed(ord("W"))) currentOption -= 2
	if (keyboard_check_pressed(ord("S"))) currentOption += 2
	if (keyboard_check_pressed(ord("A")))
	{
		if (currentOption % 2 == 0) currentOption += 1
		else currentOption -= 1
	}
	if (keyboard_check_pressed(ord("D")))
	{
		if (currentOption % 2 == 0) currentOption += 1
		else currentOption -= 1
	}

	if (keyboard_check_pressed(vk_up)) currentOption -= 2
	if (keyboard_check_pressed(vk_down)) currentOption += 2
	if (keyboard_check_pressed(vk_left))
	{
		if (currentOption % 2 == 0) currentOption += 1
		else currentOption -= 1
	}
	if (keyboard_check_pressed(vk_right))
	{
		if (currentOption % 2 == 0) currentOption += 1
		else currentOption -= 1
	}
}

if (currentOption < 0) currentOption += 4
if (currentOption > 3) currentOption -= 4
