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
for (const name of ['LearnsMoveAt','GetLevelUpMoveset','GetLearnsetPP','GetMovePP','GetPokemonType','AddPokemonTrainer'])
 vm.runInContext(extract(pokemon,name).replace(/\band\b/g,'&&').replace(/\bor\b/g,'||'),c);
c.HasFlag = flag => flag === 'CollectorFirstBattle';
c.MEGABOTSprite = 'MEGABOTSprite';
vm.runInContext(extract(battle,'GetTrainerTeam'),c);
const team = c.GetTrainerTeam('Collector');
assert.equal(team.length,1);
const mega = team[0];
assert.equal(mega[1],'MEGA BOT');
assert.equal(mega[2],25);
assert.equal(mega[4],'MEGABOTSprite');
assert.equal(mega[5],85,'Boss HP must use the new stats');
assert.deepEqual(Array.from(mega[10]),['Electric','Steel']);
assert.deepEqual(Array.from(mega[6]),['Hyper Beam','Giga Impact','Thunderbolt','Body Slam']);
assert(mega[7].every(pp=>pp>0),'All attacks have usable PP');
const componentMoves = new Set();
for (const name of ['Voltorb','Magnemite','Box Bot','BB-8','Tutorial Bot'])
 for(let level=1;level<=100;level++) {
  const move=c.LearnsMoveAt(name,level);if(move)componentMoves.add(move);
 }
for(const move of mega[6]) {
 assert(componentMoves.has(move),'Move must belong to a component robot: '+move);
 assert(c.GetMovePower(move)>=85,'Boss uses powerful attacks');
 assert.notEqual(c.GetMoveEffect(move),'FaintUser');
 assert(c.GetDamage({name:'MEGA BOT',level:25,types:mega[10]},
  {name:'Human',level:25,types:['Normal']},move)>0);
}
assert.deepEqual(Array.from(c.GetPokemonBaseStats('MEGA BOT')),[100,110,110,115,90,75]);
console.log('Collector MEGA BOT creation, four component moves, PP, typing, boss stats, and damage checks passed.');
