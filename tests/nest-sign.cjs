// Run: node tests/nest-sign.cjs
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
process.chdir(path.join(__dirname, '..'));
const source = fs.readFileSync('scripts/RoomFunctions/RoomFunctions.gml', 'utf8');
function extract(name) {
  const start = source.indexOf('function ' + name + '(');
  assert(start >= 0);
  let depth = 0;
  for (let i = source.indexOf('{', start); i < source.length; i++) {
    if (source[i] === '{') depth++;
    if (source[i] === '}' && --depth === 0) return source.slice(start, i + 1);
  }
}
const c = {ds_list_create:()=>[], ds_list_add:(a,...v)=>a.push(...v),
  ds_list_size:a=>a.length, ds_list_find_value:(a,i)=>a[i],
  ds_list_find_index:(a,v)=>a.indexOf(v), ds_list_destroy:()=>{},
  string_concat:(...s)=>s.join(''), irandom:n=>n};
vm.createContext(c);
for (const name of ['GetNestEncounterPool','GetNestRoomPokemonType'])
  vm.runInContext(extract(name),c);
const expected = {
  'Moltres Area Key':['Godzooky','Andalite','Moltres'],
  'Zapdos Area Key':['Pac-Man','Zergling','Zapdos'],
  'Rancor Area Key':['Moosephant','Xenomorph','Rancor','Articuno'],
  'Field Area Key':['Pikachu','Squirtle'],
};
const signPath = 'rooms/NestAreaRoom/InstanceCreationCode_inst_NestSpeciesSign.gml';
const sign = fs.readFileSync(signPath,'utf8');
for (const [key, species] of Object.entries(expected)) {
  c.GameObject={areaKeyInfo:key}; c.textList=[];
  const pool=Array.from(c.GetNestEncounterPool(key));
  assert.deepEqual([...new Set(pool)],species);
  vm.runInContext(sign,c);
  assert.equal(c.textList[0],'Chance of catching these Pokémon:');
  assert.equal(c.textList.at(-1),'Some of them are sleeping now. Come back later to find them all!');
  const pages=c.textList.slice(1,-1);
  assert(pages.every(p=>p.split('\n').length<=3));
  assert.deepEqual(pages.join('\n').split('\n'),species.map(s=>'- '+s));
  for(let i=0;i<pool.length;i++) {
    c.irandom=()=>i;
    assert.equal(c.GetNestRoomPokemonType(key),pool[i]);
  }
}
// Both grass and the sign must use the same data as roaming spawns.
assert(extract('GetAreaEncounters').includes('return GetNestEncounterPool(global.lastKeyUsed)'));
const parse=p=>JSON.parse(fs.readFileSync(p,'utf8').replace(/,\s*([}\]])/g,'$1'));
const room=parse('rooms/NestAreaRoom/NestAreaRoom.yy');
const instance=room.layers.flatMap(l=>l.instances||[]).find(i=>i.name==='inst_NestSpeciesSign');
assert.equal(instance.objectId.name,'BasicSign'); assert.equal(instance.hasCreationCode,true);
assert(room.instanceCreationOrder.some(i=>i.name===instance.name));
assert(fs.existsSync(signPath));
console.log('Passed all nest sign lists, pagination, weighted spawns including Articuno, shared grass pool, and room sign references.');
