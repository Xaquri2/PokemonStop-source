const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
const pokemon = fs.readFileSync(path.join(__dirname, '../scripts/PokemonFunctions/PokemonFunctions.gml'), 'utf8');
const battle = fs.readFileSync(path.join(__dirname, '../scripts/BattleFunctions/BattleFunctions.gml'), 'utf8');
function extract(source, name) {
  const start = source.indexOf('function ' + name + '(');
  assert(start >= 0, name);
  let depth = 0;
  for (let i = source.indexOf('{', start); i < source.length; i++) {
    if (source[i] === '{') depth++;
    if (source[i] === '}' && --depth === 0) return source.slice(start, i + 1);
  }
  throw Error('Missing function body: ' + name);
}
const c = {
  noone: -4, FindBattlePokemonEntity: () => -4,
  GetName: p => p.name, GetLevel: p => p.level, GetTypes: p => p.types,
  ds_list_create: () => [], ds_list_add: (a, ...v) => a.push(...v),
  ds_list_size: a => a.length, ds_list_find_value: (a, i) => a[i], ds_list_destroy: () => {},
  floor: Math.floor, max: Math.max, clamp: (v, lo, hi) => Math.max(lo, Math.min(hi, v)),
};
vm.createContext(c);
for (const name of ['GetPokemonBaseStats', 'GetPokemonFinalStats', 'GetMoveDetails',
  'GetHPStat', 'GetAtkStat', 'GetDefStat', 'GetSpAtkStat', 'GetSpDefStat', 'GetSpeedStat',
  'GetMoveType', 'GetMoveCategory', 'GetMovePower', 'GetMoveAccurancy', 'GetMoveEffect', 'GetMoveCritMultiplier']) {
  vm.runInContext(extract(pokemon, name), c);
}
for (const name of ['GetDamage', 'GetEffectPower', 'IsImmune', 'IsTypeSuperEffective',
  'IsTypeNotVeryEffective', 'IsMoveSuperEffective', 'IsMoveNotVeryEffective']) {
  vm.runInContext(extract(battle, name).replace(/\band\b/g, '&&').replace(/\bor\b/g, '||'), c);
}
const missingno = { name: 'MissingNo', level: 15, types: ['???'] };
const dog = { name: 'Demo Dog', level: 11, types: ['Dark'] };
const stats = c.GetPokemonFinalStats(missingno.name, missingno.level);
const dogStats = c.GetPokemonFinalStats(dog.name, dog.level);
const incoming = Math.max(...['Bite', 'Scratch', 'Headbutt'].map(move => c.GetDamage(dog, missingno, move)));
for (const move of ['Wing Attack', 'Gust']) {
  const damage = c.GetDamage(missingno, dog, move);
  const turnsToWin = Math.ceil(dogStats[0] / damage);
  // Even if Demo Dog attacks first every turn, ordinary damage must not win this matchup.
  assert(turnsToWin <= 3, move + ' should defeat the lower-level dog within three hits');
  assert(stats[0] > incoming * turnsToWin, move + ' should win from full health without luck');
  console.log(`${move}: ${damage} damage, ${turnsToWin} hits to win; Demo Dog deals at most ${incoming} per hit.`);
}
assert(stats[1] > stats[3], 'Physical Attack remains its strongest offense');
assert(c.GetDamage(missingno, dog, 'Hyper Beam') > c.GetDamage(missingno, dog, 'Gust'),
  'Later special attacks should benefit from the same buff');
console.log('MissingNo level-15 versus level-11 Demo Dog balance checks passed.');
