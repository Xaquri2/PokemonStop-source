const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const assert = require('node:assert/strict');
for (const object of ['Obj_Lighting', 'Obj_Lighting_City3']) {
  const source = fs.readFileSync(path.join(__dirname, '..', 'objects', object, 'Draw_0.gml'), 'utf8');
  const start = source.indexOf('// Camera sizes');
  const end = source.indexOf('// get camera position', start);
  assert(start >= 0 && end > start);
  const code = source.slice(start, end).replace(/\bor\b/g, '||');
  let width = 400, height = 400, created = 0, freed = 0;
  const surfaces = new Map([[0, [400, 400]]]);
  const c = {
    light_surface: 0, view_camera: [1], max: Math.max, ceil: Math.ceil,
    camera_get_view_width: () => width, camera_get_view_height: () => height,
    surface_exists: id => surfaces.has(id),
    surface_get_width: id => surfaces.get(id)[0], surface_get_height: id => surfaces.get(id)[1],
    surface_free: id => { freed++; surfaces.delete(id); },
    surface_create: (w, h) => { created++; surfaces.set(created, [w, h]); return created; },
  };
  vm.createContext(c);
  for (const [w, h] of [[400, 400], [480, 480], [640, 360], [400.25, 400.75]]) {
    width = w; height = h;
    vm.runInContext(code, c);
    assert.deepEqual(surfaces.get(c.light_surface), [Math.ceil(w), Math.ceil(h)]);
    const before = created;
    vm.runInContext(code, c);
    assert.equal(created, before, 'Stable camera must reuse the surface');
  }
  assert.equal(freed, 3);
  surfaces.clear();
  vm.runInContext(code, c);
  assert(surfaces.has(c.light_surface), 'Lost surfaces are recreated');
}
console.log('Both lighting overlays passed room resize, aspect ratio, fractional zoom, reuse, and surface-loss checks.');
