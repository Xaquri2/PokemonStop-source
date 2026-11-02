const fs = require('node:fs');
const vm = require('node:vm');
const path = require('node:path');
const assert = require('node:assert/strict');
const root = path.join(__dirname, '..');
const read = p => fs.readFileSync(path.join(root, p), 'utf8');
const parse = p => JSON.parse(read(p).replace(/,\s*([}\]])/g, '$1'));
const dir = 'objects/ShadowPathTrailRenderer/';
const surfaces = new Map([[1, [0.2, 1]]]);
let next = 2, visible = true, gpuStack = 0;
const c = {
  application_surface: 1, view_current: 0,
  view_visible: [true, false], view_camera: [10, 11],
  view_xport: [0, 0], view_yport: [0, 0], view_wport: [960, 1366], view_hport: [960, 768],
  c_white: 1, bm_one: 1, bm_zero: 0, bm_normal: 2, room: 7, ShadowPath: 7,
  layerelementtype_sprite: 4, array_length: a => a.length,
  layer_get_id: n => n, layer_get_visible: () => visible, layer_get_depth: () => 500,
  layer_get_all_elements: () => [42], layer_get_element_type: () => 4, layer_exists: () => true,
  layer_sprite_get_sprite: () => 1, layer_sprite_get_index: () => 0,
  layer_sprite_get_x: () => 100, layer_sprite_get_y: () => 200,
  layer_sprite_get_xscale: () => 0.3, layer_sprite_get_yscale: () => 0.4,
  layer_sprite_get_angle: () => 0, layer_sprite_get_blend: () => 1,
  layer_sprite_get_alpha: () => 1,
  draw_sprite_ext: () => { const p = surfaces.get(1); surfaces.set(1, [p[0] * 0.5, p[1] * 0.75]); },
  surface_exists: id => surfaces.has(id), surface_get_width: () => 2, surface_get_height: () => 1,
  surface_create: () => { const id = next++; surfaces.set(id, [0, 0]); return id; },
  surface_free: id => surfaces.delete(id),
  surface_copy: (dest, x, y, src) => surfaces.set(dest, [...surfaces.get(src)]),
  layer_set_visible: (name, value) => { assert.equal(name, 'FadingTiles'); visible = value; },
  gpu_push_state: () => gpuStack++, gpu_pop_state: () => gpuStack--,
  gpu_set_ztestenable: () => {}, gpu_set_zwriteenable: () => {}, gpu_set_blendmode_ext: () => {}, gpu_set_blendmode: () => {},
  camera_get_view_x: () => 0, camera_get_view_y: () => 0,
  camera_get_view_width: () => 2, camera_get_view_height: () => 1,
  draw_surface_stretched_ext: src => surfaces.set(1, [...surfaces.get(src)]),
};
vm.createContext(c);
function run(file) {
  const code = read(dir + file).replace(/\band\b/g, '&&').replace(/\bor\b/g, '||').replace(/\bexit\b/g, 'return');
  vm.runInContext('(function() {\n' + code + '\n})();', c);
}
// Create variables are instance fields in GML; expose them as VM globals here.
vm.runInContext(read(dir + 'Create_0.gml'), c);
assert.equal(c.view_camera[1], c.view_camera[0]);
function frame(actor = false) {
  for (c.view_current = 0; c.view_current <= 1; c.view_current++) {
    run('Draw_72.gml');
    assert.equal(visible, false, 'asset layer stays hidden in both passes');
    run('Draw_0.gml');
    let image = surfaces.get(1);
    if (actor) image[0] = 1;
    surfaces.set(1, image);
    run('Draw_73.gml');
    assert.equal(gpuStack, 0);
  }
}
for (let i = 0; i < 120; i++) {
  frame();
  assert.deepEqual(surfaces.get(1), [0.1, 0.75]);
  assert.deepEqual(surfaces.get(c.historySurface), [0.2, 1]);
}
frame(true);
assert.deepEqual(surfaces.get(1), [1, 0.75], 'actor renders above gradient');
frame();
assert.deepEqual(surfaces.get(1), [0.5, 0.75], 'actor trail remains visible through gradient');
// Losing the surface must recover without touching a target stack.
const oldHistory = c.historySurface;
surfaces.delete(oldHistory);
frame();
assert(surfaces.has(c.historySurface));
run('CleanUp_0.gml');
assert.equal(visible, true);
assert(!surfaces.has(c.historySurface));
assert.equal(c.view_visible[1], false);
assert.equal(c.view_camera[1], 11);
assert.equal(c.view_wport[1], 1366);
const resource = parse(dir + 'ShadowPathTrailRenderer.yy');
assert(resource.eventList.some(e => e.eventType === 8 && e.eventNum === 73));
assert(!resource.eventList.some(e => e.eventType === 3));
for (const file of ['Create_0.gml', 'Draw_0.gml', 'Draw_72.gml', 'Draw_73.gml', 'CleanUp_0.gml'])
  assert(!/surface_set_target\s*\(|layer_script_(begin|end)\s*\(/.test(read(dir + file)), 'no cross-event surface targets or layer callbacks');
const room = parse('rooms/ShadowPath/ShadowPath.yy');
assert.equal(room.viewSettings.clearViewBackground, false);
assert.equal(room.layers.find(l => l.name === 'Background').visible, false);
console.log('Passed two-view transparency/trails, foreground ordering, surface loss, viewport restoration, and no cross-event surface targets.');
