// Run: node tests/morlock-trainers.cjs
// Checks shared event logic through JavaScript engine adapters, not GameMaker.
const fs = require('node:fs');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const path = require('node:path');
process.chdir(path.join(__dirname,'..'));
const read = p => fs.readFileSync(p,'utf8').replace(/\r\n/g,'\n');
const js = s => s.replace(/\band\b/g,'&&').replace(/\bor\b/g,'||');
const names=['Morlock Tunnel Scout','Morlock Bridge Sentry'];
for(const name of [...names,'Legacy Morlock Trainer']) {
 let destroyed=false;
 const c={name,self:1,instance_destroy:()=>{destroyed=true;}};
 vm.createContext(c);
 vm.runInContext(js(read('objects/MorlockTrainer/KeyPress_101.gml')),c);
 assert.equal(destroyed,!names.includes(name));
}
const destroy=read('objects/BattleObject/Destroy_0.gml');
const a=destroy.indexOf('\t\tfor (var i = 0; i < instance_number(enemyObjectType); i++)');
const b=destroy.indexOf('\n\t\tdialogue.textList',a);
assert(a>=0&&b>a);
for(const winner of names) {
 const npcs=['BridgeMorlock',...names.filter(n=>n!==winner),winner].map(name=>({name}));
 const c={enemyObjectType:1,enemyName:winner,dialogue:{},
  instance_number:()=>npcs.length,instance_find:(_,i)=>npcs[i]};
 vm.createContext(c);vm.runInContext(js(destroy.slice(a,b)),c);
 assert.equal(c.dialogue.actionNPC.name,winner);
}
// Fail clearly if room creation-code references point to deleted files.
const room=JSON.parse(read('rooms/MorlockCity3/MorlockCity3.yy').replace(/,\s*([}\]])/g,'$1'));
const missing=room.layers.flatMap(l=>l.instances||[])
 .filter(i=>i.objectId?.name==='MorlockTrainer'&&i.hasCreationCode)
 .map(i=>`rooms/MorlockCity3/InstanceCreationCode_${i.name}.gml`)
 .filter(p=>!fs.existsSync(p));
assert.deepEqual(missing,[],'Room still references missing trainer creation scripts');
console.log('Passed new-trainer E protection, legacy behavior, post-battle identity binding, and room script references.');
