const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const assert = require('node:assert/strict');
const read = p => fs.readFileSync(path.join(__dirname, '..', p), 'utf8');
const closeDialogue = read('objects/TextboxObject/Alarm_1.gml')
  .replace(/\band\b/g, '&&').replace(/\bor\b/g, '||');
const unlock = read('objects/PlayerObject/Alarm_1.gml');
function close(npc, beaten = []) {
  const player = { talking: true, canWalk: false, alarm: { 1: -1 } };
  const c = {
    player, actionNPC: npc, Morlock: 'Morlock', global: { beatenTrainers: beaten },
    startBattle: false, item: '', itemCount: 1, id: 1,
    instance_exists: p => p !== null, ds_list_empty: a => a.length === 0,
    ds_list_find_index: (a, v) => a.indexOf(v), instance_destroy: () => {},
    AddItem: () => assert.fail('Conversation must not award items'),
  };
  vm.runInNewContext(closeDialogue, c);
  if (player.alarm[1] === 1) vm.runInNewContext(unlock, player);
  return { player, startBattle: c.startBattle };
}
// Roaming Morlocks keep a battle team even while the potion makes them friendly.
for (const team of [[], ['Morlock']]) {
  const result = close({ object_index: 'Morlock', name: 'Morlock', trainerTeam: team });
  assert.equal(result.startBattle, false);
  assert.equal(result.player.talking, false, 'Morlock conversation releases talking lock');
  assert.equal(result.player.canWalk, true, 'Morlock conversation restores movement');
}
const trainer = { object_index: 'Trainer', name: 'Scout', trainerTeam: ['Demo Dog'] };
assert.equal(close(trainer).startBattle, true, 'Unbeaten trainers still start battles');
for (const result of [close(trainer, ['Scout']), close(null),
  close({ object_index: 'NPC', name: 'Villager', trainerTeam: [] })]) {
  assert.equal(result.startBattle, false);
  assert.equal(result.player.canWalk, true);
  assert.equal(result.player.talking, false);
}
console.log('Morlock dialogue movement reset, trainer battles, and ordinary dialogue checks passed.');
