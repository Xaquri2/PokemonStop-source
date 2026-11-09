const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const read = p => fs.readFileSync(path.join(__dirname, '..', p), 'utf8');
const options = read('objects/OptionObject/Step_0.gml');
const section = options.slice(options.indexOf('//Nebogipfel//'), options.indexOf('instance_destroy(id)', options.indexOf('//Nebogipfel//')));
const room = read('rooms/NebogipfelsStudy/InstanceCreationCode_inst_74BE9D4E.gml');
let checked = 0;
for (const source of [section, room]) {
  const code = source.replace(/^\s*\/\/.*$/gm, '');
  const calls = [...code.matchAll(/ds_list_add\(((?:"(?:\\.|[^"\\])*"|[^"\)])*)\)/g)];
  let lists;
  function verify() {
    if (!lists) return;
    assert.equal(lists.nameList.length, lists.textList.length,
      'Missing speaker for: ' + lists.textList[0]);
    assert.equal(lists.iconList.length, lists.textList.length,
      'Missing portrait for: ' + lists.textList[0]);
    for (const name of lists.nameList) assert(['Morlock', 'Nebogipfel'].includes(name));
    for (const icon of lists.iconList) assert.equal(icon, 'NebogipfelSprite');
    checked += lists.textList.length;
  }
  for (const call of calls) {
    const target = call[1].match(/^\s*(?:dialogue\.)?(textList|nameList|iconList)\s*,/);
    if (!target) continue;
    if (target[1] === 'textList') {
      verify();
      lists = { textList: [], nameList: [], iconList: [] };
    }
    vm.runInNewContext('capture(' + call[1].slice(target[0].length) + ')', {
      NebogipfelSprite: 'NebogipfelSprite', sprite_index: 'overworld sprite',
      capture: (...values) => lists[target[1]].push(...values),
    });
  }
  verify();
}
assert(checked >= 90, 'Audit must cover the full conversation and room greetings');
console.log(`Checked names and portraits for all ${checked} Nebogipfel dialogue lines.`);
