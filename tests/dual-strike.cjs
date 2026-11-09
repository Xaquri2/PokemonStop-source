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
const details = c.GetMoveDetails;
c.GetMoveDetails = move => {
  if (move !== 'Single Strike') return details(move);
  const result = details('Dual Strike');
  result[0] = move; result[6] = 'None';
  return result;
};
assert.equal(c.GetMoveCategory('Dual Strike'), 'Physical');
assert.equal(c.GetMovePower('Dual Strike'), 40);
assert.equal(c.GetMoveAccurancy('Dual Strike'), 100);
assert.equal(c.GetMoveEffect('Dual Strike'), 'DualStrike');
const attacker = {name:'Demogorgon',level:18,types:['Dark','Psychic']};
for (const types of [['Normal'], ['Psychic'], ['Dark'], ['Fairy']]) {
  const target = {name:'Human',level:17,types};
  assert.equal(c.GetDamage(attacker,target,'Dual Strike'),
    2*c.GetDamage(attacker,target,'Single Strike'),
    'Two physical hits must each include STAB and type effectiveness');
}
c.BattleObject = {Fluxxed2:false,playerFieldEffects:[],enemyFieldEffects:[]};
c.BattleTextboxObject = {textList:[]};
c.random_range = () => 0;
c.string_count = (needle, text) => text.split(needle).length - 1;
c.ds_list_find_index = (list, value) => list.indexOf(value);
vm.runInContext(extract(battle,'DealEffect').replace(/\band\b/g,'&&').replace(/\bor\b/g,'||')
  .replace(/^\s*#(?:end)?region.*$/gm,''),c);
for (const playerTeam of [true,false]) {
  const message = c.DealEffect('Dual Strike','DualStrike',100,20,
    {playerTeam,pkmnInfo:attacker}, {pkmnInfo:{types:['Normal']},inhaled:false});
  assert.equal(message,'It strikes twice!');
}
console.log('Dual Strike physical damage, two-hit total, STAB, resistances, and both-side effect text checks passed.');
