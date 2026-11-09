// Run with: node tests/after-credits-warp.cjs
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
const read = p => fs.readFileSync(path.join(__dirname, '..', p), 'utf8');
const transition = read('objects/AfterCreditsController/Step_0.gml')
    .split('if pauseOver2 == true {')[1].split('}')[0];
const roomStart = read('objects/GameObject/Other_4.gml');
const clearArrival = roomStart.match(/if \(warp and targetWarp == "None"\)\s*\{[^}]+\}/)[0]
    .replace(/\band\b/g, '&&');
const exit = read('objects/WarpObject/Collision_PlayerObject.gml').split('/*')[0];

for (const staleTarget of ['', 'None', 'UnrelatedPreviousWarp']) {
    const game = { warp: false, targetWarp: staleTarget };
    const context = vm.createContext({ GameObject: game, RouteMinusOneBottom: 'route' });
    vm.runInContext(transition, context);
    assert.equal(game.targetRoom, 'route');
    assert.equal(game.warp, true);
    // Room Start must release the transition without a matching WarpObject.
    vm.runInNewContext(clearArrival, game);
    assert.equal(game.warp, false);
    const other = { canWalk: true };
    vm.runInNewContext(exit, {
        game, other, is_door: false, is_stairs: false,
        targetRoom: 'town', targetWarp: 'MalletToMinusOne'
    });
    assert.equal(game.targetRoom, 'town');
    assert.equal(game.targetWarp, 'MalletToMinusOne');
    assert.equal(game.warp, true);
    assert.equal(other.canWalk, false);
}
console.log('After-credits return clears warp state and allows the next exit.');
