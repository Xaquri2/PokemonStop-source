const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const assert = require('node:assert/strict');
const read = p => fs.readFileSync(path.join(__dirname, '..', p), 'utf8');
const source = read('scripts/NPCFunctions/NPCFunctions.gml');
const adapt = s => s.replace(/\band\b/g, '&&').replace(/\bor\b/g, '||')
  .replace(/repeat \(ds_list_size\((npc\.\w+)\)\)/g,
    'for (let j = 0; j < ds_list_size($1); j++)');
const helper = adapt(source.slice(source.indexOf('function RefreshMorlockTrainerDialogue('),
  source.indexOf('function PostBattleFlagActivation(')));
const step = adapt(read('objects/MorlockTrainer/Step_0.gml'));
for (const name of ['BridgeMorlock', 'Morlock Tunnel Scout']) {
  let flags = [], textboxOpen = false, inherited = 0;
  const c = {
    name, sprite_index: 'portrait', triggered: false, TextboxObject: 1,
    global: { morlockTimer: 0 }, HasFlag: f => flags.includes(f),
    instance_exists: () => textboxOpen,
    variable_instance_exists: (o, key) => Object.hasOwn(o, key),
    event_inherited: () => inherited++, ds_list_clear: a => { a.length = 0; },
    ds_list_add: (a, ...v) => a.push(...v), ds_list_size: a => a.length,
    textList: ['Hsssss!!'], nameList: [], iconList: [],
    postBattleTextList: [], postBattleNameList: [], postBattleIconList: [],
  };
  c.id = c;
  vm.createContext(c);
  vm.runInContext(helper, c);
  for (const [timer, state, friendly] of [
    [0, [], false], [600, [], true], [0, [], false],
    [0, ['Potion'], true], [0, ['Potion', 'PotionCure'], false],
    [600, ['Potion', 'PotionCure'], true],
  ]) {
    c.global.morlockTimer = timer; flags = state;
    vm.runInContext(step, c);
    assert.equal(c.morlockDialogueDisguised, friendly);
    assert.match(c.textList[0], friendly ? /fellow Morlock|Hey buddy/ : /human culture|A Human/);
    assert.match(c.postBattleTextList[0], friendly ? /Good match|practice harder/ : /NOT to eat|human/);
    for (const [text, names, icons] of [
      [c.textList, c.nameList, c.iconList],
      [c.postBattleTextList, c.postBattleNameList, c.postBattleIconList],
    ]) {
      assert.equal(text.length, names.length);
      assert.equal(text.length, icons.length);
      assert(icons.every(icon => icon === 'portrait'));
    }
  }
  // Do not change shared dialogue lists midway through a conversation or encounter.
  const before = [...c.textList];
  c.global.morlockTimer = 0; textboxOpen = true;
  vm.runInContext(step, c);
  assert.deepEqual(c.textList, before);
  textboxOpen = false; c.triggered = true;
  vm.runInContext(step, c);
  assert.deepEqual(c.textList, before);
  assert.equal(inherited, 8, 'Trainer battle logic still runs every step');
}
console.log('MorlockCity3 trainer potion, expiry, legacy flags, portraits, and encounter checks passed.');
