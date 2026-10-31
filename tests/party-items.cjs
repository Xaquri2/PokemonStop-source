// Run: node tests/party-items.cjs (GML logic through JavaScript adapters).
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
process.chdir(path.join(__dirname, '..'));
const read = p => fs.readFileSync(p, 'utf8');
function extract(source, name) {
  const start = source.indexOf('function ' + name + '(');
  assert(start >= 0, name);
  let depth = 0;
  for (let i = source.indexOf('{', start); i < source.length; i++) {
    if (source[i] === '{') depth++;
    if (source[i] === '}' && --depth === 0) return source.slice(start, i + 1);
  }
  throw Error('Unclosed ' + name);
}
const inventory = read('scripts/InventoryFunctions/InventoryFunctions.gml');
const pokemon = read('scripts/PokemonFunctions/PokemonFunctions.gml');
let entity, popups = [];
const c = {
  noone: -4, BattleObject: 1, BattlePokemonObject: 2, BattleTextboxObject: 3,
  max: Math.max, min: Math.min, floor: Math.floor,
  ds_list_find_value: (a, i) => a[i], ds_list_set: (a, i, v) => a[i] = v,
  ds_list_size: a => a.length, ds_list_find_index: (a, v) => a.indexOf(v),
  ds_list_destroy: () => {},
  GetName: p => p[1], GetLevel: p => p[2], GetHealth: p => p[5],
  GetMoves: p => p[6], GetExp: p => p[8], GetGrowth: p => p[9], GetStatus: p => p[11],
  ClearStatus: p => p[11] = 'None',
  GetPokemonFinalHP: (_, level) => 20 + level * 2,
  GetPokemonFinalStats: (_, level) => [20 + level * 2, level, level, level, level, level],
  GetHPStat: s => s[0], GetAtkStat: s => s[1], GetDefStat: s => s[2],
  GetSpAtkStat: s => s[3], GetSpDefStat: s => s[4], GetSpeedStat: s => s[5],
  SetFinalStat: (v, mod) => v * (1 + mod / 2),
  FindBattlePokemonEntity: p => entity?.pkmnInfo === p ? entity : -4,
  instance_number: () => entity ? 1 : 0, instance_find: () => entity,
  instance_exists: () => false,
  LearnsMoveAt: (_, level) => level === 24 ? 'Iron Defense' : '',
  LearnMove: (p, move) => { p[6].push(move); p[7].push(15); },
  GenerateTextPopup: (_, __, text) => popups.push(text),
  string_concat: (...parts) => parts.join(''), string_count: (a, b) => b.split(a).length - 1,
};
vm.createContext(c);
for (const [source, names] of [[pokemon, ['AddExp', 'GetExpLevelFloor', 'HealPokemon']],
  [inventory, ['ApplyPokemonItem', 'GetHealValue', 'IsConsumableItem', 'IsBattleItem', 'GetItemDescription']]])
  for (const name of names) vm.runInContext(extract(source, name).replace(/^\s*#(?:end)?region.*$/gm, '').replace(/\band\b/g, '&&').replace(/\bor\b/g, '||'), c);
const mon = (level = 23, hp = 30, moves = []) => [0, 'Test', level, 'Male', 0, hp, moves, [], 120, 'Average', [], 'Poisoned'];
assert.equal(c.IsConsumableItem('Rare Candy'), true);
assert(c.GetItemDescription('Rare Candy').includes('one level'));
for (const growth of ['Very Fast', 'Fast', 'Average', 'Slow', 'Very Slow']) {
  const p = mon(); p[9] = growth;
  assert(c.ApplyPokemonItem([p], 0, 'Rare Candy'));
  assert.equal(p[2], 24); assert.equal(p[8], 0); assert.equal(p[5], 32);
  assert.deepEqual(p[6], ['Iron Defense']); assert.deepEqual(p[7], [15]);
}
const full = mon(23, 0, ['a', 'b', 'c', 'd']);
assert(c.ApplyPokemonItem([full], 0, 'Rare Candy'));
assert.equal(full[5], 0); assert.equal(full[6].length, 4);
assert(popups.at(-1).includes('Summary'));
const cap = mon(99); assert(c.ApplyPokemonItem([cap], 0, 'Rare Candy'));
assert.equal(cap[2], 100); assert.equal(cap[8], 0);
const before = JSON.stringify(cap);
assert.equal(c.ApplyPokemonItem([cap], 0, 'Rare Candy'), false);
assert.equal(JSON.stringify(cap), before);
for (const battle of [false, true]) for (const status of ['Poisoned', 'Burn', 'Sleep', 'Paralysis', 'None']) {
  const p = mon();
  p[11] = status;
  entity = battle ? {pkmnInfo:p, playerTeam:true, hp:30, toxic:true, toxicCount:3, sleepCounter:4} : undefined;
  assert(c.ApplyPokemonItem([p], 0, 'Full Restore'));
  assert.equal(p[5], 66); assert.equal(p[11], 'None');
  if (battle) { assert.equal(entity.hp, 66); assert.equal(entity.status, 'None'); assert.equal(entity.toxic, false); }
}
const active = mon(), bench = mon(23, 10);
entity = {pkmnInfo:active, playerTeam:true, hp:30};
assert(c.ApplyPokemonItem([active, bench], 1, 'Full Restore'));
assert.equal(entity.hp, 30); assert.equal(active[11], 'Poisoned'); assert.equal(bench[11], 'None');
entity = undefined;
const potion = mon(); assert(c.ApplyPokemonItem([potion], 0, 'Potion'));
assert.equal(potion[5], 50); assert.equal(potion[11], 'Poisoned');
const raised = mon();
entity = {pkmnInfo:raised, playerTeam:true, hp:30, statList:[], attackModifier:2,
  defenseModifier:0, spAtkModifier:0, spDefModifier:0, speedModifier:0};
assert(c.ApplyPokemonItem([raised], 0, 'Rare Candy'));
assert.equal(entity.level, 24); assert.equal(entity.hp, 32); assert.equal(entity.atk, 48);
console.log('Passed Rare Candy growth rates, learning, full moves, fainted/cap cases, battle stats, Full Restore, benched healing, and ordinary potion behavior.');
