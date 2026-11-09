// Run with: node tests/progression.cjs
// Executes the changed GML logic under small JS adapters. This is not a
// substitute for compiling or playing the project in GameMaker.
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
process.chdir(path.join(__dirname,'..'));
const read = p => fs.readFileSync(p,'utf8').replace(/\r\n/g,'\n');
const pokemon = read('scripts/PokemonFunctions/PokemonFunctions.gml');
function extract(source, name) {
 const start = source.indexOf('function ' + name + '(');
 assert(start >= 0, name);
 let depth = 0, opened = false;
 for(let i = source.indexOf('{',start); i < source.length; i++) {
  if(source[i] === '{') {depth++; opened=true;}
  if(source[i] === '}' && --depth === 0 && opened) return source.slice(start,i+1);
 }
 throw Error('Unclosed ' + name);
}
const gmlToJs = source => source.replace(/\band\b/g,'&&').replace(/\bor\b/g,'||');
const flags = new Set();
const textBox = {textList:[],currentText:0};
const runtime = {
 max:Math.max,min:Math.min,floor:Math.floor,
 ds_list_set:(list,i,value) => list[i]=value,
 ds_list_size:list => list.length,
 ds_list_find_index:(list,value) => list.indexOf(value),
 ds_list_insert:(list,i,value) => list.splice(i,0,value),
 ds_list_add:(list,...values) => list.push(...values),
 ds_list_create:() => [], ds_list_find_value:(list,i) => list[i],
 GetExp:p => p[8], GetLevel:p => p[2], GetGrowth:p => p[9],
 GetName:p => p[1],GetMoves:p => p[6],
 LearnMove:(p,move) => {p[6].push(move);},
 HasFlag:flag => flags.has(flag), irandom_range:(a,b) => [a,b],
 BattleTextboxObject:textBox,instance_exists:() => true,
 string_concat:(...args) => args.join(''),
 Mallet_Town:'town',RouteMinusOneBottom:'bottom',RouteMinusOneTop:'top',
 MutantPath1:'mutant',ShadowPath:'shadow',RobotPath:'robot'
};
vm.createContext(runtime);
for(const name of ['GetExpLevelFloor','LearnsMoveAt','GetLevelUpMoveset','GetWildEncounterLevel','AddExp'])
 vm.runInContext(gmlToJs(extract(pokemon,name)),runtime);
const mon = (level=5,xp=0,growth='Very Fast',name='Pikachu',moves=[]) =>
 [0,name,level,'Male',0,100,moves,[],xp,growth];
const state = p => [p[2],p[8]];
for(const [award,expected] of [[599,[5,599]],[600,[6,0]],[1000,[6,400]], [1300,[7,0]], [2000,[7,700]]]) {
 const p=mon(); runtime.AddExp(p,award,false); assert.deepEqual(state(p),expected);
}
let cases=0;
for(const growth of ['Very Fast','Fast','Average','Slow','Very Slow']) {
 for(const level of [1,5,16,23,32,98,99,100]) {
  for(const award of [0,1,178,1000,10000,1000000]) {
   const bulk=mon(level,37,growth), animated=mon(level,37,growth);
   runtime.AddExp(bulk,award,false);
   let remaining=award;
   while(remaining>0) {
    const chunk=Math.min(remaining,remaining<=200?1:remaining<=500?5:remaining<=1000?10:20);
    runtime.AddExp(animated,chunk,false); remaining-=chunk;
   }
   // Zero awards do not enter the animation loop.
   if(award===0) runtime.AddExp(animated,0,false);
   assert.deepEqual(state(bulk),state(animated),`${growth}, L${level}, ${award}`);
   assert(bulk[2] <= 100);
   if(bulk[2]<100) assert(bulk[8]<runtime.GetExpLevelFloor(bulk[2]+1,growth));
   else assert.equal(bulk[8],0);
   cases++;
  }
 }
}
const learner=mon(23,0,'Very Fast','Pikachu',['Tackle']);
runtime.AddExp(learner,2400,true);
assert(learner[6].includes('Iron Defense'));
const full=mon(23,0,'Very Fast','Pikachu',['Tackle','Thunder Wave','Quick Attack','Thunderbolt']);
runtime.AddExp(full,2400,true);
assert.equal(full[6].length,4);
assert(textBox.textList.some(t=>t.includes('Iron Defense')));

for(let count=0;count<=3;count++) {
 flags.clear(); ['MutantBadge','ShadowBadge','RobotBadge'].slice(0,count).forEach(f=>flags.add(f));
 const range = area => Array.from(runtime.GetWildEncounterLevel(area));
 assert.deepEqual(range('town'),[1,2]); assert.deepEqual(range('bottom'),[2,4]);
 assert.deepEqual(range('top'),[4+count*3,7+count*3]);
 for(const area of ['mutant','shadow','robot']) assert.deepEqual(range(area),[7+count*3,10+count*3]);
}
const learnSource = extract(pokemon,'LearnsMoveAt').replace(/\/\*[\s\S]*?\*\//g,'').replace(/\/\/[^\n]*/g,'');
const details = extract(pokemon,'GetMoveDetails');
const supported = new Set([...details.matchAll(/case "([^"]+)":/g)].map(m=>m[1]));
let lateSpecies=0;
for(const match of learnSource.matchAll(/case "([^"]+)":/g)) {
 const name=match[1];
 const late=[24,32].map(level=>runtime.LearnsMoveAt(name,level));
 // Scripted bosses can have a fixed moveset instead of normal later progression.
 if(name==='Godzilla'||name==='Green Bubble'||name==='MEGA BOT') {assert.deepEqual(late,['','']);continue;}
 assert(late.every(Boolean),name+' missing later moves');
 const early=new Set(Array.from({length:23},(_,i)=>runtime.LearnsMoveAt(name,i+1)).filter(Boolean));
 for(const move of late) {
  assert(supported.has(move),name+' unsupported '+move);
  assert(!early.has(move),name+' already learns '+move);
  assert(!['Protect','Magic Coat','Redirect'].includes(move),'Unfinished late move');
 }
 assert.notEqual(late[0],late[1]);
 assert(runtime.GetLevelUpMoveset(name,32).includes(late[0]));
 assert(runtime.GetLevelUpMoveset(name,32).includes(late[1]));
 lateSpecies++;
}
const battle=read('scripts/BattleFunctions/BattleFunctions.gml');
const bands = [[20,23,['Mildred']], [23,26,['Bonnie','Gladys','Roxanne']],
 [26,29,['Spike','Marnie','Jett']], [29,32,['Sable','Cruz','Nyx','Harlow','Gage','Vesper','Dante','Kira']]];
let opponents=0;
for(const [min,max,names] of bands) for(const name of names) {
 const start=battle.indexOf(`case "Team Rocket ${name}":`);
 const block=battle.slice(start,battle.indexOf('break',start));
 const levels=[...block.matchAll(/AddPokemonTrainer\(team,\s*\d+,\s*"[^"]+",\s*(\d+)/g)].map(m=>+m[1]);
 assert.equal(levels.length,5,name); opponents+=levels.length;
 assert(levels.every(l=>l>=min&&l<=max),name+' outside floor band');
}
assert(battle.includes('"Godzilla", 40, "Male"'));
assert.deepEqual(Array.from(runtime.GetLevelUpMoveset('Godzilla',40)),['Giga Impact','Iron Defense','Crunch','Bulldoze']);
const step=read('objects/BattleTextboxObject/Step_0.gml');
const animation=step.slice(step.indexOf('\tvar level = GetLevel(playerPkmn)'),step.indexOf('\n\tvar levelNew'));
for(const award of [1,178,201,501,1001,10000]) {
 const p=mon(); const expected=mon(); runtime.AddExp(expected,award,false);
 Object.assign(runtime,{playerPkmn:p,expGainValue:award,expGaining:true});
 let ticks=0;
 while(runtime.expGaining) {vm.runInContext(gmlToJs(animation),runtime);assert(++ticks<10000);}
 assert.deepEqual(state(p),state(expected));assert.equal(runtime.expGainValue,0);
}
const alarm=read('objects/BattleTextboxObject/Alarm_2.gml');
assert(alarm.includes('else if (string_count("like to replace", text) > 0)'));
// Exercise the restored full-moveset prompt and its accept/decline paths.
Object.assign(runtime,{
 ds_list_delete:(list,i) => list.splice(i,1), instance_destroy:()=>{},
 instance_create_layer:()=>({}),id:0,
 playerPkmn:mon(24,0,'Very Fast','Pikachu',['Tackle','Thunder Wave','Quick Attack','Thunderbolt']),
 level:23,leveledUp:false,expGainValue:0,listLevelUpMoves:[],currentText:0,
 textList:['Your Pokemon gained 2400 EXP','You win!']
});
const learning = step.slice(step.indexOf('\tvar levelNew ='),step.indexOf('\n\tvar activePkmnEntity'));
vm.runInContext(gmlToJs(learning),runtime);
assert.deepEqual(Array.from(runtime.listLevelUpMoves),['Iron Defense']);
assert(runtime.textList.includes('Would you like to replace one?'));
assert.equal(runtime.textList.at(-1),'You win!');
const options=read('objects/OptionObject/Step_0.gml');
const replaceStart=options.indexOf('if (string_count("replace", question) > 0)');
const replaceEnd=options.indexOf('if (string_count("stop learning", question)',replaceStart);
const replaceChoice=options.slice(replaceStart,replaceEnd);
runtime.string_count=(part,text)=>text.split(part).length-1;
runtime.question='Would you like to replace a move?';
runtime.newMove='Iron Defense';
runtime.menu={textList:['Would you like to replace one?','You win!'],currentText:0,listLevelUpMoves:['Iron Defense'],playerPkmn:runtime.playerPkmn};
runtime.currentOption=1;
vm.runInContext(gmlToJs(replaceChoice),runtime);
assert.equal(runtime.menu.listLevelUpMoves.length,0);
assert.equal(runtime.menu.textList.at(-1),'You win!');
assert(runtime.menu.textList[1].includes('did not learn'));
const moveReplace=read('objects/MoveReplaceObject/Step_0.gml');
runtime.menu={textList:['Would you like to replace one?','You win!'],currentText:0,listLevelUpMoves:['Iron Defense'],playerPkmn:runtime.playerPkmn};
runtime.moveList=runtime.playerPkmn[6];runtime.currentOption=0;
runtime.vk_enter=13;runtime.ord=s=>s.charCodeAt(0);runtime.keyboard_check_pressed=key=>key===13;
runtime.LearnMove=(p,move,pos)=>{if(pos>=0)p[6][pos]=move;else p[6].push(move);};
vm.runInContext(gmlToJs(moveReplace.slice(moveReplace.indexOf('if (keyboard_check_pressed(vk_enter))'))),runtime);
assert.equal(runtime.playerPkmn[6][0],'Iron Defense');
assert.equal(runtime.menu.listLevelUpMoves.length,0);
assert.equal(runtime.menu.textList.at(-1),'You win!');
// Explicit scope guard: existing Exp All and participant checks remain as-is.
assert(alarm.includes('if (global.expAll) AddExp(partyMemberInfo, floor(expGainValue/2), true)'));
assert(alarm.includes('else if (ds_list_find_index(battle.battleParticipants, partyMemberInfo) != undefined)'));
console.log(`Passed ${cases} XP chunk/cap cases, animated XP awards, learning notifications, all badge encounter bands, ${lateSpecies} later learnsets, and ${opponents} tower opponents.`);
