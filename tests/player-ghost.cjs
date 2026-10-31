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
