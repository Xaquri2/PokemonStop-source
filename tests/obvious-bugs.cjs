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
  floor: Math.floor, max: Math.max, clamp: (v, lo, hi) => Math.max(lo, Math.min(hi, v))
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
for (const move of ['Storm Throw']) {
  assert.equal(context.GetDamage(mon(['Normal']), ghost, move), -1, move);
  assert.equal(context.DealEffect(move, context.GetMoveEffect(move), 100, 0,
    {playerTeam: true}, {pkmnInfo: ghost}), '', move);
}
for (const move of ['Body Slam', 'Giga Impact']) {
  const normal = context.GetDamage(mon(['Normal']), mon(['Water']), move);
  assert.equal(context.GetDamage(mon(['Normal']), ghost, move), Math.floor(normal / 2));
}
for (const playerTeam of [true, false]) {
  const target = {pkmnInfo: ghost, attackModifier: 0};
  assert(context.DealEffect('Growl', 'LowerAttack', 100, 0, {playerTeam}, target));
  assert.equal(target.attackModifier, -1);
}
assert(context.GetDamage(mon(['Grass', 'Fighting']), ghost, 'Vine Whip') > 0);

// Mary's level-5 Creeper only knows Tackle, now resisted by Envy's Ghost type.
// Exercise both speed branches, random selection, depleted PP, and mixed moves.
const ai = {
  ...context,
  GetLevel: p => p.level,
  GetMoves: p => p.moves,
  GetMovePPList: p => p.pp,
  GetPokemonFinalStats: name => ({speed: name === 'Creeper' ? 50 : 55}),
  GetSpeedStat: stats => stats.speed,
  ds_list_empty: list => list.length === 0,
  random_range: () => 1,
  irandom: () => 0
};
vm.createContext(ai);
for (const name of ['LearnsMoveAt', 'GetLevelUpMoveset'])
  vm.runInContext(adapt(extract(pokemonSource, name)), ai);
vm.runInContext(adapt(extract(battle, 'ChooseMove')), ai);
const creeper = {name: 'Creeper', level: 5, types: ['Grass'],
  moves: ai.GetLevelUpMoveset('Creeper', 5), pp: [35]};
const envy = {name: 'Envy', level: 5, types: ['Water', 'Ghost', 'Dark']};
assert.deepEqual(Array.from(creeper.moves), ['Tackle']);
assert(ai.GetDamage(creeper, envy, 'Tackle') > 0);
for (const speed of [40, 55, 60]) {
  ai.GetDamage = context.GetDamage;
  // Give Envy its own speed so both the slower/tied and faster paths run.
  ai.GetPokemonFinalStats = name => ({speed: name === 'Creeper' ? speed : 55});
  for (const roll of [0, 1]) {
    ai.random_range = () => roll;
    assert.equal(ai.ChooseMove(creeper, envy), 'Tackle');
  }
  creeper.pp = [0];
  assert.equal(ai.ChooseMove(creeper, envy), 'Struggle');
  creeper.pp = [35];
  ai.GetDamage = (_user, _target, move) => move === 'Tackle' ? -1 : 0;
  ai.random_range = () => 1;
  creeper.moves = ['Tackle', 'Grassy Surge'];
  creeper.pp = [35, 20];
  assert.equal(ai.ChooseMove(creeper, envy), 'Grassy Surge');
  creeper.moves = ['Tackle'];
  creeper.pp = [35];
}

// Zoombini's early Normal status moves bypass Ghost damage immunity.
// Check every early level, either speed ordering, and every random move slot.
ai.GetDamage = context.GetDamage;
for (let level = 1; level <= 7; level++) {
  const moves = ai.GetLevelUpMoveset('Zoombini', level);
  const zoombini = {name: 'Zoombini', level, types: ['Fairy'],
    moves, pp: Array(moves.length).fill(15)};
  for (const move of moves) assert.equal(ai.GetDamage(zoombini, envy, move), 0);
  for (const speed of [40, 55, 60]) {
    ai.GetPokemonFinalStats = name => ({speed: name === 'Zoombini' ? speed : 55});
    for (const roll of [0, 1, 2]) {
      ai.random_range = () => roll;
      for (let slot = 0; slot < moves.length; slot++) {
        ai.irandom = () => slot;
        assert(moves.includes(ai.ChooseMove(zoombini, envy)),
          `Zoombini level ${level}, speed ${speed}, roll ${roll}, slot ${slot}`);
      }
    }
    zoombini.pp.fill(0);
    assert.equal(ai.ChooseMove(zoombini, envy), 'Struggle');
    zoombini.pp.fill(15);
  }
}

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
    instance_exists: value => value === menu.player,
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
console.log('Passed move priority/speed/ties, target immunity, Creeper and Zoombini vs Envy move selection, and all five empty-slot navigation/close cases.');
