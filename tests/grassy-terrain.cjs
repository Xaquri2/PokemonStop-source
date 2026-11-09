const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
const source = fs.readFileSync(path.join(__dirname, '../objects/BattleTextboxObject/Alarm_2.gml'), 'utf8');
const start = source.indexOf('else if (text == "All pokémon on the field have been healed!")');
assert(start >= 0);
const end = source.indexOf('else if (string_count("spat out", text)', start);
assert(end > start);
const block = source.slice(source.indexOf('{', start), end).replace(/\band\b/g, '&&').replace(/\bor\b/g, '||');
const healed = [];
const mon = (hp, types = ['Grass']) => ({ hp, types });
// Trainer entities intentionally have no hp property.
const entities = [
  { team: [mon(10)], currentPkmn: 0, player: true },
  { team: [mon(20)], currentPkmn: 0, player: false },
  { team: [mon(0)], currentPkmn: 0, player: true },
  { team: [mon(10, ['Flying'])], currentPkmn: 0, player: false },
  { team: [], currentPkmn: -1, player: true },
  { team: [], currentPkmn: 0, player: false },
];
vm.runInNewContext(block, {
  BattleEntityObject: 1,
  instance_number: () => entities.length,
  instance_find: (_, i) => entities[i],
  instance_exists: entity => entities.includes(entity),
  ds_list_size: list => list.length,
  ds_list_find_value: (list, i) => list[i],
  ds_list_find_index: (list, value) => list.indexOf(value),
  GetHealth: p => p.hp, GetTypes: p => p.types,
  GetName: () => 'Creeper', GetLevel: () => 6,
  GetPokemonFinalHP: () => 32, floor: Math.floor,
  HealPokemon: (team, index, amount, player, status, pp) => healed.push({ team, index, amount, player, status, pp }),
});
assert.deepEqual(healed, entities.slice(0, 2).map(e => ({ team: e.team, index: 0, amount: 2, player: e.player, status: false, pp: false })));
// Field processing must also work when misses/protection skip DealEffect and
// no effStr local was assigned during the turn.
const battleFunctions = fs.readFileSync(path.join(__dirname, '../scripts/BattleFunctions/BattleFunctions.gml'), 'utf8');
const fieldFunction = battleFunctions.match(/function CheckForFieldEffect\(tList\)\s*\{[^}]*\}/);
assert(fieldFunction, 'Field check only needs the message list');
const menu = fs.readFileSync(path.join(__dirname, '../objects/BattleMenuObject/Step_0.gml'), 'utf8');
const calls = menu.match(/CheckForFieldEffect\([^\n]*\)/g);
assert.equal(calls.length, 2);
for (const currentField of ['None', 'GrassyTerrain']) {
  for (const call of calls) {
    const messages = [];
    vm.runInNewContext(fieldFunction[0] + '\n' + call, {
      BattleObject: { currentField }, battleText: { textList: messages },
      ds_list_add: (list, ...values) => list.push(...values),
    });
    assert.deepEqual(messages, currentField === 'GrassyTerrain'
      ? ['All pokémon on the field have been healed!'] : []);
  }
}
console.log('Grassy Terrain healing and field checks without a move-effect result passed.');
