// Run: node tests/bag-cancel.cjs
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const assert = require('node:assert/strict');
process.chdir(path.join(__dirname, '..'));
const read = file => fs.readFileSync(file, 'utf8');
const adapt = text => text.replace(/\band\b/g, '&&').replace(/\bor\b/g, '||');
const resource = JSON.parse(read('objects/PokemonMenuObject/PokemonMenuObject.yy').replace(/,\s*([}\]])/g, '$1'));
assert(!resource.eventList.some(event => event.eventType === 9 && event.eventNum === 69),
  'Back must be handled only by Step, without destroying the parent menu in Key Press');
const partyBack = adapt(read('objects/PokemonMenuObject/Step_0.gml').split('if (keyboard_check_pressed(vk_enter)')[0]);
const bagBack = adapt(read('objects/BagMenuObject/Step_0.gml').split('if (keyboard_check_pressed(vk_enter)')[0]);
const bagClose = read('objects/BagMenuObject/Alarm_0.gml');
const parent = {active: false, visible: false};
const bag = {menu: parent, hasSelected: true, optionMenu: -4, battle: false, alarm: []};
const party = {};
const destroyed = new Set();
const common = {
  noone: -4, TextboxObject: 1, ord: value => value,
  keyboard_check_pressed: key => key === 'E', instance_number: () => 0,
  instance_exists: value => value && value !== -4 && !destroyed.has(value),
  instance_destroy: value => destroyed.add(value),
};
const selection = {...common, id: party, bagMenu: bag, canInteract: true};
// Cancel the target selection, then leave the bag on the following Back press.
vm.runInNewContext(partyBack, selection);
assert(destroyed.has(party));
assert(!destroyed.has(parent));
assert.equal(bag.hasSelected, false);
assert.equal(parent.active, false);
const inventory = {...common, ...bag, id: bag};
vm.runInNewContext(bagBack, inventory);
assert.equal(bag.alarm[0], 1);
vm.runInNewContext(bagClose, inventory);
assert.equal(parent.active, true);
assert.equal(parent.visible, true);
assert(destroyed.has(bag));
// A stale parent reference must also be safe during delayed close.
destroyed.add(parent);
inventory.menu = new Proxy({}, {set() { throw Error('Wrote to missing parent'); }});
destroyed.add(inventory.menu);
vm.runInNewContext(bagClose, inventory);
console.log('Passed potion selection cancellation, return to parent menu, and missing-parent close.');
