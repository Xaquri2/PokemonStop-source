const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const read = p => fs.readFileSync(path.join(__dirname, '..', p), 'utf8');
const source = read('scripts/MerchantFunctions/MerchantFunctions.gml');
const greeting = source.slice(0, source.indexOf('function IsMerchant'))
  .replace(/\band\b/g, '&&').replace(/\bor\b/g, '||');
let flags = [];
const c = { global: { morlockTimer: 0 }, HasFlag: f => flags.includes(f) };
vm.createContext(c);
vm.runInContext(greeting, c);
for (const [timer, state, friendly] of [
  [0, [], false], [600, [], true], [1, [], true], [0, [], false],
  [0, ['Potion'], true], [0, ['Potion', 'PotionCure'], false],
  [600, ['Potion', 'PotionCure'], true],
]) {
  c.global.morlockTimer = timer;
  flags = state;
  assert.equal(c.GetMorlockShopkeeperGreeting(), friendly
    ? 'Hey cutie!! What can I getcha??' : 'Hssss!!');
}
const player = read('objects/PlayerObject/Step_0.gml');
assert(player.includes('ds_list_set(nearestNPC.textList, 0, GetMorlockShopkeeperGreeting())'),
  'Refresh greeting on each interaction, even without reentering the shop');
assert(read('rooms/MorlockShop/InstanceCreationCode_inst_41E89565.gml')
  .includes('ds_list_add(textList, GetMorlockShopkeeperGreeting())'));
console.log('Shopkeeper human, active potion, expiry, and legacy transformation checks passed.');
