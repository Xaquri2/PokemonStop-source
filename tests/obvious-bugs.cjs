// Run with: node tests/obvious-bugs.cjs
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
process.chdir(path.join(__dirname, '..'));
const read = p => fs.readFileSync(p, 'utf8');
const battle = read('scripts/BattleFunctions/BattleFunctions.gml');
function extract(source, name) {
  const start = source.indexOf('function ' + name + '(');
  assert(start >= 0);
  let depth = 0;
  for (let i = source.indexOf('{', start); i < source.length; i++) {
    if (source[i] === '{') depth++;
    if (source[i] === '}' && --depth === 0) return source.slice(start, i + 1);
  }
  throw Error('Unclosed function: ' + name);
}
const adapt = s => s.replace(/\band\b/g, '&&').replace(/\bor\b/g, '||');
let coin = 0;
const context = {
  irandom: () => coin, noone: -4,
  GetName: p => p.name, GetLevel: () => 10, GetTypes: p => p.types,
  GetPokemonFinalStats: () => [30, 20, 20, 20, 20, 20],
  FindBattlePokemonEntity: () => -4,
  GetMoveType: () => 'Electric', GetMovePower: () => 40,
  GetMoveAccurancy: () => 100, GetMoveCategory: () => 'Special',
  GetMoveCritMultiplier: () => 0, GetSpAtkStat: s => s[3], GetSpDefStat: s => s[4],
  GetMoveEffect: () => '', GetEffectPower: () => 0,
  IsMoveSuperEffective: () => false, IsMoveNotVeryEffective: () => false,
  ds_list_size: a => a.length, ds_list_find_value: (a, i) => a[i],
  floor: Math.floor, clamp: (v, lo, hi) => Math.max(lo, Math.min(hi, v))
};
vm.createContext(context);
for (const name of ['PlayerMovesFirst', 'IsImmune', 'GetDamage'])
  vm.runInContext(adapt(extract(battle, name)), context);
for (coin = 0; coin <= 1; coin++) {
  assert.equal(context.PlayerMovesFirst(1, 0, 10, 100), true);
  assert.equal(context.PlayerMovesFirst(0, 1, 100, 10), false);
  assert.equal(context.PlayerMovesFirst(0, 0, 100, 10), true);
  assert.equal(context.PlayerMovesFirst(0, 0, 10, 100), false);
  assert.equal(context.PlayerMovesFirst(0, 0, 10, 10), coin === 1);
}
const mon = types => ({name: 'Test', types});
assert.equal(context.GetDamage(mon(['Electric']), mon(['Ground']), 'Test'), -1);
assert.equal(context.GetDamage(mon(['Electric']), mon(['Water', 'Ground']), 'Test'), -1);
assert(context.GetDamage(mon(['Ground']), mon(['Water']), 'Test') > 0);

// Ewok's field traps bypass Ghost immunity; direct attacks still obey it.
const pokemonSource = read('scripts/PokemonFunctions/PokemonFunctions.gml');
context.ds_list_create = () => [];
context.ds_list_destroy = () => {};
context.ds_list_add = (list, ...values) => list.push(...values);
for (const name of ['GetMoveDetails', 'GetMoveType', 'GetMovePower', 'GetMoveAccurancy',
  'GetMoveCategory', 'GetMoveCritMultiplier', 'GetMoveEffect'])
  vm.runInContext(adapt(extract(pokemonSource, name)), context);
vm.runInContext(adapt(extract(battle, 'DealEffect')).replace(/^\s*#(?:end)?region.*$/gm, ''), context);
const field = {enemyFieldEffects: [], playerFieldEffects: []};
context.BattleObject = {Fluxxed2: false, playerFieldEffects: [], enemyFieldEffects: []};
context.string_count = (needle, value) => value.split(needle).length - 1;
context.ds_list_find_index = (list, value) => list.indexOf(value);
context.instance_find = () => field;
context.random_range = () => 0;
context.GetAtkStat = s => s[1];
context.GetDefStat = s => s[2];
const ghost = mon(['Ghost']);
for (const playerTeam of [true, false]) {
  for (const move of ['Set Trap', "Wicket's Reversal"]) {
    const effect = context.GetMoveEffect(move);
    assert.equal(context.GetDamage(mon(['Grass', 'Fighting']), ghost, move), 0);
    assert(context.DealEffect(move, effect, 100, 0, {playerTeam}, {pkmnInfo: ghost}));
    assert((playerTeam ? field.enemyFieldEffects : field.playerFieldEffects).includes(
      effect === 'SetTrap' ? 'SetTrap' : 'ReversalTrap'));
  }
}
for (const move of ['Body Slam', 'Storm Throw', 'Giga Impact']) {
  assert.equal(context.GetDamage(mon(['Normal']), ghost, move), -1, move);
  assert.equal(context.DealEffect(move, context.GetMoveEffect(move), 100, 0,
    {playerTeam: true}, {pkmnInfo: ghost}), '', move);
}
assert(context.GetDamage(mon(['Grass', 'Fighting']), ghost, 'Vine Whip') > 0);

// Execute the menu event for each missing slot, then verify navigation and close.
const saveStep = adapt(read('objects/SaveMenuObject/Step_0.gml'));
for (let slot = 0; slot < 5; slot++) {
  let key = 'enter', destroyed = false;
  const menu = {
    active: true, selectedIndex: slot, mode: 'Load',
    optionsList: ['1', '2', '3', '4', '5'], global: {}, player: {alarm: []},
    vk_enter: 'enter', vk_up: 'up', vk_down: 'down', ord: s => s,
    keyboard_check_pressed: k => k === key,
    string_concat: (...a) => a.join(''), file_exists: () => false,
    ds_list_find_value: (a, i) => a[i], ds_list_size: a => a.length,
    instance_destroy: () => { destroyed = true; },
    SaveStateAction: () => { throw Error('Loaded missing slot'); }
  };
  vm.createContext(menu);
  vm.runInContext(saveStep, menu);
  assert.equal(menu.active, true);
  key = 'down';
  vm.runInContext(saveStep, menu);
  assert.equal(menu.selectedIndex, (slot + 1) % 5);
  key = 'E';
  vm.runInContext(saveStep, menu);
  assert.equal(destroyed, true);
}
console.log('Passed move priority/speed/ties, target immunity, and all five empty-slot navigation/close cases.');
