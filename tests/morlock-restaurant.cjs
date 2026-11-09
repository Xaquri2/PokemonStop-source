const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const assert = require('node:assert/strict');
const root = path.join(__dirname, '..');
const source = fs.readFileSync(path.join(root, 'scripts/NPCFunctions/NPCFunctions.gml'), 'utf8');
const helpers = source.slice(source.indexOf('function ConfigureMorlockDialogue('),
  source.indexOf('function RefreshMorlockTrainerDialogue('))
  .replace(/\band\b/g, '&&').replace(/\bor\b/g, '||');
const dir = path.join(root, 'rooms/MorlockRestaurant');
let checked = 0;
for (const file of fs.readdirSync(dir).filter(f => f.endsWith('.gml'))) {
  const code = fs.readFileSync(path.join(dir, file), 'utf8');
  if (!code.includes('ConfigureMorlockDialogue')) continue;
  let flags = [];
  const npc = { textList: [], nameList: [], iconList: [], sprite_index: 'portrait' };
  const c = {
    id: npc, global: { morlockTimer: 0 }, HasFlag: f => flags.includes(f),
    array_length: a => a.length, ds_list_clear: a => { a.length = 0; },
    ds_list_add: (a, ...v) => a.push(...v),
  };
  vm.createContext(c);
  vm.runInContext(helpers, c);
  vm.runInContext(code, c);
  for (const [timer, state, friendly] of [
    [0, [], false], [600, [], true], [1, [], true], [0, [], false],
    [0, ['Potion'], true], [0, ['Potion', 'PotionCure'], false],
    [600, ['Potion', 'PotionCure'], true],
  ]) {
    c.global.morlockTimer = timer; flags = state;
    c.RefreshMorlockDialogue(npc);
    assert.deepEqual(npc.textList, Array.from(friendly ? npc.morlockFriendlyText : npc.morlockHumanText));
    assert.equal(npc.textList.length, npc.nameList.length);
    assert.equal(npc.textList.length, npc.iconList.length);
    assert(npc.nameList.every(name => name === 'Morlock'));
    assert(npc.iconList.every(icon => icon === 'portrait'));
    assert.equal(npc.textList[0].startsWith('Hsss'), !friendly);
  }
  checked++;
}
assert.equal(checked, 9);
const player = fs.readFileSync(path.join(root, 'objects/PlayerObject/Step_0.gml'), 'utf8');
assert(player.includes('RefreshMorlockDialogue(nearestNPC)'));
console.log('All nine restaurant Morlocks passed potion, expiry, legacy flags, name, and portrait checks.');
