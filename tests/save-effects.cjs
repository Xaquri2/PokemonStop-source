// Run: node tests/save-effects.cjs. Executes save/load GML with in-memory files.
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
process.chdir(path.join(__dirname, '..'));
const source = fs.readFileSync('scripts/DataFunctions/DataFunctions.gml', 'utf8');
function extract(name, sourceText = source) {
  const source = sourceText;
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
  string_concat:(...s)=>s.join(''), string_split:(s, delimiter)=>s.split(delimiter),
  string_length:s=>s.length, file_exists:p=>files.has(p),
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
  assert.equal(saved.saveSlotTimestamp, '2026-04-03 01:02');
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

// Each row must inspect its own file, regardless of the last selected slot.
vm.runInContext(extract('GetSaveSlotTimestamp').replace(/\band\b/g, '&&'), c);
for (let slot = 1; slot <= 5; slot++) {
  const data = JSON.parse(files.get(`savefile${slot}.json`));
  data[`saveState${slot}`].saveSlotTimestamp = `Slot ${slot} timestamp`;
  files.set(`savefile${slot}.json`, JSON.stringify(data));
}
c.global.saveFile = 5;
for (let slot = 1; slot <= 5; slot++)
  assert.equal(c.GetSaveSlotTimestamp(slot), `Slot ${slot} timestamp`);
const oldDate = JSON.parse(files.get('savefile1.json'));
oldDate.saveState1.saveSlotTimestamp = '9:5 1/11/2026';
files.set('savefile1.json', JSON.stringify(oldDate));
assert.equal(c.GetSaveSlotTimestamp(1), '2026-11-01 09:05');
oldDate.saveState1.saveSlotTimestamp = '2026-11-01 09:05';
files.set('savefile1.json', JSON.stringify(oldDate));
assert.equal(c.GetSaveSlotTimestamp(1), '2026-11-01 09:05');

// A missing state inside an existing file must preserve the current progress.
c.show_debug_message = () => {};
c.string = String;
c.global.flags = ['KeepFlag'];
c.global.beatenTrainers = ['Mary'];
c.global.activatedBadges = ['Badge'];
c.global.collectedPokeloot = ['Loot'];
c.global.npcFlags = {Mary: true};
const beforeMissing = JSON.stringify(c.global);
files.set('savefile5.json', '{}');
c.LoadData();
assert.equal(JSON.stringify(c.global), beforeMissing);

// Startup must terminate even when slot 5 exists, and select the first save.
const startup = fs.readFileSync('objects/GameObject/Other_2.gml', 'utf8');
const scan = startup.slice(startup.indexOf('var count = 1'), startup.indexOf('//Testing'));
for (const slots of [[], [1], [5], [1, 5], [2, 3, 4, 5]]) {
  const boot = {global: {saveFile: 1}, string_concat: (...s) => s.join(''),
    file_exists: filename => slots.some(slot => filename === `savefile${slot}.json`)};
  vm.runInNewContext(scan, boot, {timeout: 1000});
  assert.equal(boot.global.saveFile, slots[0] || 1);
}
console.log('Passed per-slot timestamps, missing-state progress preservation, and startup with slot 5 present.');

// Round-trip real Pokemon records, party order, PC membership and inventory.
const pokemonSource = fs.readFileSync('scripts/PokemonFunctions/PokemonFunctions.gml', 'utf8');
c.global.pokedex = [];
c.GetName = p => p[1];
c.GetCatchIndex = p => p[0];
c.GetPartyMemberInfo = (team, index) => team[index];
vm.runInContext(extract('AddPokemonSpecific', pokemonSource).replace(/\band\b/g, '&&').replace(/\bor\b/g, '||'), c);
for (let slot = 1; slot <= 5; slot++) {
  const records = Array.from({length: 8}, (_, i) =>
    [slot * 100 + i, i % 2 ? 'Envy' : 'Creeper', 5 + i, 'Female', 0,
      10 + i, ['Tackle', 'Growl'], [20, 30], 123 + i, 'Average',
      i % 2 ? ['Water', 'Ghost', 'Dark'] : ['Grass'], 'Poisoned']);
  c.global.saveFile = slot;
  c.global.currentSaveState = slot;
  c.global.pokemonList = records;
  c.global.playerParty = [records[7], records[1], records[3]];
  c.global.categoryItemList = [[['Potion', slot]], [['Poke Ball', 12]], [], [], [['Moltres Area Key', 1]]];
  c.global.money = 1000 + slot;
  player.x = slot * 10;
  player.y = slot * 20;
  const expected = JSON.stringify({records, party: c.global.playerParty,
    inventory: c.global.categoryItemList, money: c.global.money});
  c.SaveData();
  c.global.pokemonList = [];
  c.global.playerParty = [];
  c.global.pcPokemonList = [];
  c.global.money = 0;
  c.LoadData();
  assert.equal(JSON.stringify({records: c.global.pokemonList, party: c.global.playerParty,
    inventory: c.global.categoryItemList, money: c.global.money}), expected);
  assert.deepEqual(Array.from(c.global.pcPokemonList, p => p[0]),
    records.filter((_, i) => ![7, 1, 3].includes(i)).map(p => p[0]));
  assert.equal(c.loadX, slot * 10);
  assert.equal(c.loadY, slot * 20);
  assert.equal(c.loadRoom, c.room);
}
console.log('Passed populated collection, HP/status/PP/XP, party ordering, PC membership, inventory, money and saved coordinates in all five slots.');

// Repair the formerly blank Shadow Tower reward exactly once per saved game.
c.AddItem = (name, amount) => {
  assert.equal(name, 'X Defense');
  const items = c.global.categoryItemList[2];
  const existing = items.find(item => item[0] === name);
  if (existing) existing[1] += amount;
  else items.push([name, amount]);
};
c.global.collectedPokeloot = ['ShadowTowreXDefense'];
c.global.categoryItemList[2] = [];
c.SaveData();
c.LoadData();
assert.deepEqual(Array.from(c.global.categoryItemList[2], item => Array.from(item)), [['X Defense', 1]]);
assert(c.global.collectedPokeloot.includes('ShadowTowerXDefense'));
c.SaveData();
c.LoadData();
assert.equal(c.global.categoryItemList[2][0][1], 1, 'saved repair must not grant duplicates');
const towerPickup = fs.readFileSync('rooms/ShadowTower/InstanceCreationCode_inst_66B0799E.gml', 'utf8');
const pickup = {};
vm.runInNewContext(towerPickup, pickup);
assert.equal(pickup.item, 'X Defense');
assert.equal(pickup.itemTag, 'ShadowTowerXDefense');
console.log('Passed Shadow Tower X Defense assignment and one-time missing-reward repair.');
