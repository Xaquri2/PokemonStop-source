const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
process.chdir(path.join(__dirname, '..'));
const adapt = file => fs.readFileSync(file, 'utf8')
  .replace(/\band\b/g, '&&')
  .replace(/with \(warp\) SetWarpDefaults\([^\n]+/g, 'SetWarpDefaults()');
const create = adapt('objects/BadgeDoorObject/Create_0.gml');
const step = adapt('objects/BadgeDoorObject/Step_0.gml');
const badges = ['MutantBadge', 'ShadowBadge', 'RobotBadge'];
let cases = 0;
for (let mask = 0; mask < 8; mask++) {
  for (const opened of [false, true]) {
    for (const activated of [[], [...badges], Array(3).fill('MutantBadge')]) {
      const flags = badges.filter((_, i) => mask & (1 << i));
      if (opened) flags.push('TowerDoorHasOpened');
      let warps = 0, destroyed = false;
      const c = {
        global: {activatedBadges: [...activated]}, textList: [],
        HasFlag: f => flags.includes(f), event_inherited() {},
        ds_list_add: (a, ...v) => a.push(...v), ds_list_clear: a => {a.length = 0;},
        instance_create_layer: () => {warps++; return {};},
        instance_destroy: () => {destroyed = true;}, SetWarpDefaults() {},
        instance_find: () => ({alarm: []}), instance_number: () => 0,
        PlayerObject: 1, BadgeObject: 2, WarpObject: 3, x: 0, y: 0, id: 4
      };
      vm.createContext(c);
      vm.runInContext(create, c);
      assert.equal(warps, mask === 7 && opened ? 1 : 0);
      if (!destroyed) {
        assert.equal(c.textList.at(-1).includes('resonate'), mask === 7);
        // Also exercise completion directly, defending against partial animations.
        c.canFreePlayer = true;
        vm.runInContext(step, c);
        assert.equal(warps, mask === 7 ? 1 : 0);
        assert.equal(destroyed, mask === 7);
        if (mask === 7) assert.deepEqual(c.global.activatedBadges, badges);
      }
      cases++;
    }
  }
}
console.log(`Passed ${cases} tower-door cases: all badge combinations, legacy opened flags, stale/duplicate activation lists, and animation completion.`);
