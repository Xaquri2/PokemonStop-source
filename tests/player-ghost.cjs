const fs=require('fs'),vm=require('vm'),assert=require('node:assert/strict');
const source=fs.readFileSync('scripts/UsefulFunctions/UsefulFunctions.gml','utf8');
let appearance=source.slice(source.indexOf('function UpdatePlayerAppearance()')).replace(/\band\b/g,'&&').replace(/\bor\b/g,'||');
let setter=source.slice(source.indexOf('function SetPlayerGhost(enabled)'),source.indexOf('// Call in player context')).replace('with (PlayerObject) UpdatePlayerAppearance()','UpdatePlayerAppearance()');
const flags=[];const c={global:{flags,morlockTimer:0},hspeed:0,vspeed:0,HasFlag:f=>flags.includes(f),ds_list_find_index:(l,v)=>l.indexOf(v),ds_list_add:(l,v)=>l.push(v),ds_list_delete:(l,i)=>l.splice(i,1)};
for(const name of source.match(/(?:GhostPlayer|PlayerMorlock|Player)(?:Idle|Walk)(?:Down|Up|Left|Right)Sprite/g))c[name]=name;
c.sprite_index=c.PlayerIdleLeftSprite;vm.createContext(c);vm.runInContext(appearance+'\n'+setter,c);
const run=s=>vm.runInContext(s,c);
run('SetPlayerGhost(true)');assert.equal(c.sprite_index,'GhostPlayerIdleLeftSprite');run('SetPlayerGhost(true)');assert.deepEqual(flags,['PlayerGhost']);
for(const [d,h,v] of [['Down',0,2],['Up',0,-2],['Right',2,0],['Left',-2,0]]){
c.hspeed=h;c.vspeed=v;run('UpdatePlayerAppearance()');assert.equal(c.sprite_index,`GhostPlayerWalk${d}Sprite`);
c.hspeed=0;c.vspeed=0;run('UpdatePlayerAppearance()');assert.equal(c.sprite_index,`GhostPlayerIdle${d}Sprite`);
}
c.global.playerGhost=false;run('UpdatePlayerAppearance()');assert.equal(c.global.playerGhost,true);
run('SetPlayerGhost(false)');assert.equal(c.sprite_index,'PlayerIdleLeftSprite');assert.equal(c.global.playerGhost,false);assert.equal(flags.length,0);
c.global.morlockTimer=10;run('SetPlayerGhost(true)');assert.equal(c.sprite_index,'GhostPlayerIdleLeftSprite');run('SetPlayerGhost(false)');assert.equal(c.sprite_index,'PlayerMorlockIdleLeftSprite');
c.global.morlockTimer=0;run('UpdatePlayerAppearance()');assert.equal(c.sprite_index,'PlayerIdleLeftSprite');
console.log('Passed ghost conversion, all walking/idle directions, flag restoration, duplicate prevention, cure, and Morlock precedence.');
// Exercise Ginkgo's actual option handler and dialogue handoff.
const optionSource=fs.readFileSync('objects/OptionObject/Step_0.gml','utf8');
const optionStart=optionSource.indexOf('\tif (question == "Shall I change you back?")');
const optionEnd=optionSource.indexOf('\n\tif (question == "React to Lilium',optionStart);
const optionCode=optionSource.slice(optionStart,optionEnd);
const player={talking:false};let reply;
Object.assign(c,{question:'Shall I change you back?',referenceNPC:{name:'Ginkgo'},PlayerObject:1,TextboxObject:2,GinkgoSprite_CLOSE:3,x:0,y:0,id:4,
 instance_find:()=>player,instance_create_depth:()=>reply={textList:[],nameList:[],iconList:[]},instance_destroy:()=>{}});
for(const choice of [1,0]) {
 run('SetPlayerGhost(true)');c.currentOption=choice;
 run(optionCode);
 assert.equal(c.global.playerGhost,choice===1);
 assert.equal(flags.includes('PlayerGhost'),choice===1);
 assert.equal(reply.textList[0],choice===0?'There, good as new!':'Sigh. Well, come back if you change your mind.');
 assert.equal(reply.nameList[0],'Ginkgo');assert.equal(player.talking,true);
}
const destroySource=fs.readFileSync('objects/TextboxObject/Destroy_0.gml','utf8');
const ginkgoCode=destroySource.slice(destroySource.indexOf('\t\tcase Ginkgo:'),destroySource.indexOf('\t\tcase Mary:'));
let menus=0,starterChanges=0;
Object.assign(c,{Ginkgo:10,player:{alarm:[]},OptionObject:11,actionNPC:{},textList:['Shall I change you back?'],
 ds_list_find_value:(l,i)=>l[i],ds_list_size:l=>l.length,
 instance_create_layer:()=>{menus++;return {optionList:[]}},GetNPCFlag:()=>undefined,SetNPCFlag:()=>starterChanges++});
const handoff=()=>run('switch (Ginkgo) { '+ginkgoCode.replace(/\bor\b/g,'||')+' }');
handoff();assert.equal(menus,1);assert.equal(c.player.alarm[1],-1);assert.equal(starterChanges,0);
for(const text of ['There, good as new!','Sigh. Well, come back if you change your mind.']){c.textList=[text];handoff();}
assert.equal(menus,1);assert.equal(starterChanges,0);
c.textList=['Choose your first Pokémon!'];handoff();assert.equal(starterChanges,1);
console.log('Passed Ginkgo Yes/No, flag removal/preservation, prompt handoff, reply closure, and starter progress isolation.');
