const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
const read = p => fs.readFileSync(path.join(__dirname, '..', p), 'utf8');
const adapt = s => s.replace(/\band\b/g, '&&').replace(/\bor\b/g, '||').replace(/\bexit\b/g, 'return');
function block(source, start) {
  const begin = source.indexOf('{', start);
  let depth = 0;
  for (let i = begin; i < source.length; i++) {
    if (source[i] === '{') depth++;
    if (source[i] === '}' && --depth === 0) return source.slice(begin, i + 1);
  }
  throw Error('Missing block');
}
const functions = read('scripts/BattleFunctions/BattleFunctions.gml');
const mon = (name, hp, status = 'None') => ({name, hp, status, level: 20});
const first = mon('First', 2, 'Poisoned'), second = mon('Second', 8), third = mon('Third', 8);
const player = mon('Woob-Wüb', 50);
const trainer = {player: false, currentPkmn: 0, team: [first, second, third], alarm: []};
let active = {pkmnInfo: first, playerTeam: false, dying: false, toxic: false, alarm: []};
const battle = {enemyName: 'Lilium', enemyPkmn: first};
let roll = 0;
const c = {
  noone: -4, BattleEntityObject: 1, BattlePokemonObject: 2, BattleObject: 3, AttackControllerObject: 4,
  instance_number: obj => obj === 1 || obj === 2 ? 1 : 0,
  instance_find: obj => obj === 1 ? trainer : obj === 2 ? active : battle,
  FindBattlePokemonEntity: p => active.pkmnInfo === p ? active : -4,
  instance_create_layer: () => ({alarm: []}),
  GetHealth: p => p.hp, GetStatus: p => p.status, GetName: p => p.name, GetLevel: p => p.level,
  GetPokemonFinalHP: () => 64, GetMoveAnimationTime: () => 30,
  GetMoveCategory: () => 'Physical', GetMoveEffect: () => 'None',
  GetEXPYield: () => 10, GetTrainerRank: () => 1, GetTrainerLoot: () => false,
  string_count: (needle, s) => s.split(needle).length - 1, string_concat: (...s) => s.join(''),
  irandom: max => { assert.equal(max, 3); return roll; },
  floor: Math.floor, max: Math.max, clamp: (v, lo, hi) => Math.max(lo, Math.min(hi, v)),
  ds_list_size: a => a.length, ds_list_find_value: (a, i) => a[i],
  ds_list_add: (a, ...v) => a.push(...v), ds_list_delete: (a, i) => a.splice(i, 1),
  alarm: [], whoAttacked: 'Player', recoil: false, playerPkmn: player, enemyPkmn: first,
  playerDamage: 5, enemyDamage: 999, damageValue: 0, damaging: false,
  moveName: 'Tackle', textList: [], currentText: 0, endBattle: false,
  global: {pikminCount: 0}, nextPkmn: -4,
};
c.id = c;
vm.createContext(c);
for (const name of ['RollBattleStatus', 'GetBattleStatusFromText', 'ScheduleBattleStatusDamage']) {
  const start = functions.indexOf('function ' + name + '(');
  const body = block(functions, start);
  vm.runInContext(adapt(functions.slice(start, functions.indexOf('{', start)) + body), c);
}
for (const [i, status] of ['Paralysis', 'Poisoned', 'Burn', 'Sleep'].entries()) {
  roll = i;
  assert.equal(c.RollBattleStatus(), status);
}
for (const [text, status] of [['paralyzed', 'Paralysis'], ['badly poisoned', 'Poisoned'], ['burned', 'Burn'], ['asleep', 'Sleep'], ['frozen', 'Freeze']])
  assert.equal(c.GetBattleStatusFromText('The opponent is now ' + text), status);
// Poison must overwrite a previous attack's damage with max HP / 16.
assert(c.ScheduleBattleStatusDamage(c, "The opponent's pokemon took poison damage"));
assert.equal(c.playerDamage, 4);
assert.equal(c.enemyDamage, 999);
assert.equal(c.moveName, 'Poison');
// An ordinary knockout followed by a queued poison tick must advance just once.
c.playerDamage = 5;
c.moveName = 'Tackle';
const alarm1 = adapt(read('objects/BattleTextboxObject/Alarm_1.gml'));
const runAlarm1 = () => vm.runInContext('(function() {\n' + alarm1 + '\n})();', c);
runAlarm1();
assert.equal(battle.enemyPkmn, first, 'replacement is not active until its send-out');
assert(c.textList.some(s => s === 'Lilium sent out Second'));
c.DealDamage = amount => { c.enemyPkmn.hp = Math.max(0, c.enemyPkmn.hp - amount); };
const step = read('objects/BattleTextboxObject/Step_0.gml');
const damageStep = block(step, step.indexOf('if (damageValue > 0 and damaging)'));
while (c.damaging) vm.runInContext('(function() {\n' + adapt(damageStep) + '\n})();', c);
assert.equal(first.hp, 0);
assert.equal(trainer.currentPkmn, 1);
assert.equal(c.ScheduleBattleStatusDamage(c, "The opponent's pokemon took poison damage"), false);
c.whoAttacked = 'Player';
runAlarm1();
assert.equal(trainer.currentPkmn, 1, 'dead target cannot advance the roster twice');
assert.equal(c.damaging, false);
const alarm2 = read('objects/BattleTextboxObject/Alarm_2.gml');
const sendOut = block(alarm2, alarm2.indexOf('if (string_count(" sent out ", text)'));
c.battle = battle;
vm.runInContext(adapt(sendOut), c);
assert.equal(c.enemyPkmn, second);
assert.equal(battle.enemyPkmn, second);
assert.equal(trainer.alarm[2], 1);
active = {pkmnInfo: second, playerTeam: false, dying: false, toxic: false, alarm: []};
assert.equal(c.ScheduleBattleStatusDamage(c, "The opponent's pokemon took poison damage"), false);
assert.equal(second.hp, 8, 'new Pokemon does not inherit poison or stale damage');
second.status = 'Burn';
assert(c.ScheduleBattleStatusDamage(c, "The opponent's pokemon took burn damage"));
assert.equal(c.playerDamage, 4);
second.status = 'Poisoned';
active.toxic = true; active.toxicCount = 8;
assert(c.ScheduleBattleStatusDamage(c, "The opponent's pokemon took poison damage"));
assert.equal(c.playerDamage, 8);
assert.equal(active.toxicCount, 4);
// A genuine poison knockout still sends the third Pokemon and can end the battle.
second.hp = 1;
active.toxic = false;
c.ScheduleBattleStatusDamage(c, "The opponent's pokemon took poison damage");
runAlarm1();
while (c.damaging) vm.runInContext('(function() {\n' + adapt(damageStep) + '\n})();', c);
assert.equal(trainer.currentPkmn, 2);
assert(c.textList.includes('Lilium sent out Third'));
vm.runInContext(adapt(sendOut), c);
assert.equal(c.enemyPkmn, third);
active = {pkmnInfo: third, playerTeam: false, dying: false, toxic: false, alarm: []};
third.hp = 1;
third.status = 'Poisoned';
c.ScheduleBattleStatusDamage(c, "The opponent's pokemon took poison damage");
runAlarm1();
assert.equal(c.endBattle, true);
assert(c.textList.includes('You win!'));
assert(!alarm2.includes('irandom('), 'message playback never rolls a second status');
assert(!read('objects/BattleMenuObject/Step_0.gml').includes('irandom(4)'), 'random-status paths never leave an unresolved fifth outcome');
console.log('Passed Hex Roulette status consistency, poison/burn/toxic damage, knockout then poison, single roster advance, and replacement send-out.');
