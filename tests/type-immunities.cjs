const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
const source = fs.readFileSync(path.join(__dirname, '../scripts/BattleFunctions/BattleFunctions.gml'), 'utf8');
function extract(name) {
  const start = source.indexOf('function ' + name + '(');
  assert(start >= 0, name);
  let depth = 0;
  for (let i = source.indexOf('{', start); i < source.length; i++) {
    if (source[i] === '{') depth++;
    if (source[i] === '}' && --depth === 0) return source.slice(start, i + 1);
  }
}
const moves = {
  Tackle: ['Normal', 'Physical'], Punch: ['Fighting', 'Physical'],
  Growl: ['Normal', 'Status'], Sing: ['Normal', 'Status'], Protect: ['Normal', 'Status'],
  Struggle: ['Normal', 'Physical'], Fire: ['Fire', 'Special'],
  Ghost: ['Ghost', 'Special'], Electric: ['Electric', 'Special'],
  Hail: ['Normal', 'Physical', 'HailMaryHit'],
};
const c = {
  noone: -4, GetName: p => p.name, GetLevel: () => 10, GetTypes: p => p.types,
  GetPokemonFinalStats: () => [30, 20, 20, 20, 20, 20],
  FindBattlePokemonEntity: () => -4,
  GetMoveType: m => moves[m][0], GetMoveCategory: m => moves[m][1],
  GetMovePower: () => 40, GetMoveAccurancy: () => 100, GetMoveCritMultiplier: () => 0,
  GetMoveEffect: m => moves[m][2] || 'None', GetEffectPower: () => 0,
  GetAtkStat: s => s[1], GetDefStat: s => s[2], GetSpAtkStat: s => s[3], GetSpDefStat: s => s[4],
  ds_list_size: a => a.length, ds_list_find_value: (a, i) => a[i],
  floor: Math.floor, max: Math.max, clamp: (v, lo, hi) => Math.max(lo, Math.min(hi, v)),
  irandom: () => 0, string_concat: (...s) => s.join(''),
};
vm.createContext(c);
for (const name of ['IsImmune', 'IsTypeSuperEffective', 'IsTypeNotVeryEffective', 'IsMoveSuperEffective', 'IsMoveNotVeryEffective', 'GetDamage', 'GetResistanceMessage'])
  vm.runInContext(extract(name).replace(/\band\b/g, '&&').replace(/\bor\b/g, '||'), c);
const user = { name: 'Attacker', types: ['Water'] };
const envy = { name: 'Envy', types: ['Water', 'Ghost', 'Dark'] };
const neutral = { name: 'Neutral', types: ['Water'] };
const ghost = { name: 'Ghost', types: ['Ghost'] };
assert.equal(c.GetDamage(user, envy, 'Tackle'), Math.floor(c.GetDamage(user, neutral, 'Tackle') / 2));
assert.equal(c.GetDamage(user, ghost, 'Tackle'), c.GetDamage(user, envy, 'Tackle'));
assert.equal(c.GetDamage(user, envy, 'Hail'), 2, 'fixed-damage effect also halved');
assert.equal(c.GetDamage(user, envy, 'Punch'), -1);
for (const move of ['Growl', 'Sing', 'Protect']) {
  assert.equal(c.GetDamage(user, envy, move), 0);
  assert.equal(c.IsMoveNotVeryEffective(move, envy), false);
}
assert.equal(c.GetDamage(user, envy, 'Struggle'), c.GetDamage(user, neutral, 'Struggle'));
assert.equal(c.GetDamage(user, { name: 'Steel Ghost', types: ['Steel', 'Ghost'] }, 'Struggle'), c.GetDamage(user, neutral, 'Struggle'));
assert.equal(c.GetDamage(user, { name: 'Normal', types: ['Normal'] }, 'Ghost'), -1);
assert.equal(c.GetDamage(user, { name: 'Ground', types: ['Ground'] }, 'Electric'), -1);
assert.equal(c.GetResistanceMessage('Tackle', envy), 'Envy was partly immune! Damage was reduced by half. ');
assert.equal(c.GetResistanceMessage('Fire', neutral), 'It was not very effective! ');
const menu = fs.readFileSync(path.join(__dirname, '../objects/BattleMenuObject/Step_0.gml'), 'utf8');
assert.equal((menu.match(/superEffStr = GetResistanceMessage\(/g) || []).length, 9, 'all turn paths use the new message');
console.log('Type immunity, status move, Struggle, half-damage, and message checks passed.');
