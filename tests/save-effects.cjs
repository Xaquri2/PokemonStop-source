// Run: node tests/save-effects.cjs. Executes save/load GML with in-memory files.
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
process.chdir(path.join(__dirname, '..'));
const source = fs.readFileSync('scripts/DataFunctions/DataFunctions.gml', 'utf8');
function extract(name) {
  const start = source.indexOf('function ' + name + '(');
  assert(start >= 0);
  let depth = 0;
  for (let i = source.indexOf('{', start); i < source.length; i++) {
    if (source[i] === '{') depth++;
    if (source[i] === '}' && --depth === 0) return source.slice(start, i + 1);
  }
  throw Error('Unclosed ' + name);
}
const files = new Map();
const player = {x:10, y:20};
let appearanceTimer;
const c = {
  global: {pokemonList:[], playerParty:[], categoryItemList:[[],[],[],[],[]],
    beatenTrainers:[], npcFlags:{}, collectedPokeloot:[], flags:[], activatedBadges:[],
    pcPokemonList:[], money:100, latestSaveState:1, followerType:0, pikminCount:0,
    catchIndex:0, saveFile:1, currentSaveState:1, standardStartRoom:100,
    lastKeyUsed:'Moltres Area Key', morlockTimer:12345},
  PlayerObject:1, noone:-4, room:200, nestReturnRoom:300, areaKeyInfo:'Moltres Area Key',
  instance_find: () => player,
  ds_list_size:a=>a.length, ds_list_find_value:(a,i)=>a[i], ds_list_set:(a,i,v)=>a[i]=v,
  ds_list_create:()=>[], ds_list_add:(a,...v)=>a.push(...v), ds_list_destroy:()=>{},
  ds_list_clear:a=>a.length=0, ds_list_empty:a=>a.length===0, ds_list_find_index:(a,v)=>a.indexOf(v),
  ds_map_clear:o=>{for(const k of Object.keys(o)) delete o[k];},
  ConvertListToArray:a=>[...a], ConvertMapToMatrix:o=>Object.entries(o),
  array_create:n=>Array(n), array_set:(a,i,v)=>a[i]=v, array_length:a=>a.length,
  date_current_datetime:()=>0, date_get_hour:()=>1, date_get_minute:()=>2,
  date_get_day:()=>3, date_get_month:()=>4, date_get_year:()=>2026,
  string_concat:(...s)=>s.join(''), file_exists:p=>files.has(p),
  file_text_open_read:p=>p, file_text_open_write:p=>p, file_text_close:()=>{},
  file_text_read_string:p=>files.get(p), file_text_write_string:(p,v)=>files.set(p,v),
  json_parse:JSON.parse, json_stringify:JSON.stringify,
  variable_struct_exists:(o,k)=>Object.hasOwn(o,k), max:Math.max, floor:Math.floor,
  HasFlag:f=>c.global.flags.includes(f), SetNPCFlag:(k,v)=>c.global.npcFlags[k]=v,
  UpdatePlayerAppearance:()=>appearanceTimer=c.global.morlockTimer,
};
vm.createContext(c);
for (const name of ['SaveData', 'LoadData'])
  vm.runInContext(extract(name).replace('with (PlayerObject) UpdatePlayerAppearance()', 'UpdatePlayerAppearance()')
    .replace(/\band\b/g,'&&').replace(/\bor\b/g,'||'), c);
for (let slot=1; slot<=5; slot++) {
  c.global.saveFile=slot; c.global.currentSaveState=slot;
  c.global.lastKeyUsed=slot%2 ? 'Moltres Area Key' : 'Zapdos Area Key';
  c.global.morlockTimer=12345+slot; c.nestReturnRoom=300+slot;
  c.SaveData();
  const saved=JSON.parse(files.get(`savefile${slot}.json`))[`saveState${slot}`];
  assert.equal(saved.lastKeyUsed, c.global.lastKeyUsed);
  assert.equal(saved.morlockTimer, 12345+slot);
  c.global.lastKeyUsed='Rancor Area Key'; c.areaKeyInfo='Rancor Area Key';
  c.global.morlockTimer=99999; c.nestReturnRoom=999;
  c.LoadData();
  assert.equal(c.global.lastKeyUsed,saved.lastKeyUsed);
  assert.equal(c.areaKeyInfo,saved.lastKeyUsed);
  assert.equal(c.nestReturnRoom,300+slot);
  assert.equal(c.global.morlockTimer,12345+slot);
  assert.equal(appearanceTimer,12345+slot,'Appearance must use restored timer');
}
// Expired potion and inactive key must replace an active session's effects.
c.global.lastKeyUsed=''; c.global.morlockTimer=0; c.nestReturnRoom=-4;
c.SaveData(); c.global.lastKeyUsed='Zapdos Area Key'; c.global.morlockTimer=1000;
c.LoadData(); assert.equal(c.global.lastKeyUsed,''); assert.equal(c.global.morlockTimer,0);
// Legacy saves cannot recover an unrecorded key/timer, but must not inherit another save's.
const legacy=JSON.parse(files.get('savefile5.json'));
for(const key of ['lastKeyUsed','nestReturnRoom','morlockTimer']) delete legacy.saveState5[key];
files.set('savefile5.json',JSON.stringify(legacy));
c.global.lastKeyUsed='Rancor Area Key'; c.global.morlockTimer=999; c.nestReturnRoom=999;
c.LoadData(); assert.equal(c.global.lastKeyUsed,''); assert.equal(c.areaKeyInfo,'');
assert.equal(c.global.morlockTimer,0); assert.equal(c.nestReturnRoom,100);
// Nest exits use their saved origin rather than the most recently visited room.
const rooms=fs.readFileSync('scripts/RoomFunctions/RoomFunctions.gml','utf8');
const exit=rooms.split('case "NestRoomToOrigin":')[1].split('break')[0];
c.GameObject=c; c.NestAreaRoom=200; c.previousRoom=999; c.nestReturnRoom=301;
vm.runInContext(exit.replace(/\bor\b/g,'||'),c);
assert.equal(c.targetRoom,301); assert.equal(c.targetWarp,'Random');
c.nestReturnRoom=-4; vm.runInContext(exit.replace(/\bor\b/g,'||'),c);
assert.equal(c.targetRoom,100);
console.log('Passed all five save slots, key/return-room/timer round trips, restored appearance ordering, inactive effects, legacy defaults, and nest exit destination.');
