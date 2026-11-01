const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const read = path => fs.readFileSync(path, 'utf8');
const create = read('objects/RoamingNPCParent/Create_0.gml');
const roomCreate = read('rooms/RegionCenter/InstanceCreationCode_inst_D76E264.gml');
// Translate GML's single-equals comparison without changing assignments.
const step = read('objects/RoamingNPCParent/Step_0.gml')
  .replace('if (canWalk = false)', 'if (canWalk == false)');
for (const [dx, dy, sprite] of [[0, -1, 12], [0, 1, 11], [1, 0, 13], [-1, 0, 13]]) {
  let blocked = false;
  const context = {
    noone: -4, event_inherited: () => {}, alarm: [],
    random_range: low => low, ds_list_add: (list, ...items) => list.push(...items),
    textList: [], iconList: [], nameList: [], name: '',
    RegionDude1FaceSprite: 9, RegionDude1Sprite: 10,
    RegionDudeWalkDownSprite: 11, RegionDudeWalkUpSprite: 12, RegionDudeWalkRightSprite: 13,
    x: 100, y: 100, image_xscale: 0.71875,
    bbox_left: 90, bbox_top: 90, bbox_right: 110, bbox_bottom: 110,
    CollisionParent: 20, abs: Math.abs, CheckForInterruptions: () => {},
    point_distance: (x1, y1, x2, y2) => Math.hypot(x2 - x1, y2 - y1),
    // GML treats noone (negative) as false in this event's bare collision check.
    collision_rectangle: () => blocked
  };
  context.move_towards_point = () => {
    context.speed = 1;
    context.hspeed = dx;
    context.vspeed = dy;
  };
  vm.createContext(context);
  vm.runInContext(create + '\n' + roomCreate, context);
  context.state = 'Walk';
  context.walkCoords = [100 + dx * 40, 100 + dy * 40];
  vm.runInContext(step, context);
  assert.equal(context.sprite_index, sprite, 'Walking must retain a valid directional sprite');
  assert.equal(context.state, 'Walk');
  blocked = true;
  vm.runInContext(step, context);
  assert.equal(context.speed, 0, 'An impending wall collision must stop movement');
  assert.equal(context.state, 'Idle');
  assert.equal(context.sprite_index, 10);
}
console.log('Passed Region Dude room setup, all four walking sprites, and stopping at walls.');
