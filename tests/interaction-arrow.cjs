// Execute the player's actual draw event with a scrolled camera.
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const source = fs.readFileSync('objects/PlayerObject/Draw_0.gml', 'utf8')
  .replace(/\band\b/g, '&&')
  .replace(/if !\(([^\n]+)\)/g, 'if (!($1))');
function draw(x, y, offset = 0, cameraX = 100, cameraY = 200) {
  let result;
  const context = {
    global: {torch: false}, showNPCText: 'Talk', talking: false, canWalk: true,
    nearestNPC: {x, y, object_index: 1}, PokelootObject: 2,
    instance_exists: () => true, draw_self: () => {},
    view_camera: [5], view_current: 0,
    camera_get_view_x: () => cameraX, camera_get_view_y: () => cameraY,
    camera_get_view_width: () => 400, camera_get_view_height: () => 300,
    sprite_get_width: () => 16, sprite_get_height: () => 16,
    ArrowSelectSprite: 3, arrowOffset: offset, image_blend: 0xffffff, image_alpha: 1,
    clamp: (v, low, high) => Math.max(low, Math.min(high, v)),
    draw_sprite_ext: (...args) => { result = args; }
  };
  vm.runInNewContext(source, context);
  return {x: result[2], y: result[3], angle: result[6]};
}
assert.deepEqual(draw(300, 300), {x: 300, y: 268, angle: 0});
for (const offset of [-5, 0, 5]) {
  const left = draw(102, 205, offset);
  assert.equal(left.angle, 270);
  assert(left.x > 102);
  const right = draw(498, 205, offset);
  assert.equal(right.angle, 90);
  assert(right.x < 498);
  for (const x of [100, 102, 300, 498, 500]) {
    for (const y of [200, 205, 231, 232, 300, 500]) {
      const arrow = draw(x, y, offset);
      assert(arrow.x - 12 >= 102 && arrow.x + 12 <= 498);
      assert(arrow.y - 12 >= 202 && arrow.y + 12 <= 498);
    }
  }
}
assert.equal(draw(300, 231, -5).angle, draw(300, 231, 5).angle);
assert.equal(draw(300, 232, -5).angle, draw(300, 232, 5).angle);
assert.deepEqual(draw(200, 100, 0, 0, 0), {x: 200, y: 68, angle: 0});
console.log('Passed interaction arrow placement, side direction, camera scrolling, bobbing, and all screen edges.');
