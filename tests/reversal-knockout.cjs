const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const read = p => fs.readFileSync(path.join(__dirname, '..', p), 'utf8');
const adapt = s => s.replace(/\band\b/g, '&&').replace(/\bor\b/g, '||').replace(/\bexit\b/g, 'return');
function block(source, start) {
  const begin = source.indexOf('{', start);
  let depth = 0;
  for (let i = begin; i < source.length; i++) {
    if (source[i] === '{') depth++;
    if (source[i] === '}' && --depth === 0) return source.slice(begin, i + 1);
  }
}
const alarm = read('objects/BattleTextboxObject/Alarm_1.gml');
const step = read('objects/BattleTextboxObject/Step_0.gml');
const tick = block(step, step.indexOf('if (damageValue > 0 and damaging)'));
for (const side of ['Player', 'Enemy']) for (const recoil of [false, true]) {
  for (const hp of [10, 20]) for (const flux of [false, true]) {
    const player = { name: 'Ally', hp: side === 'Enemy' ? hp : 50 };
    const ewok = { name: 'Ewok', hp: side === 'Player' ? hp : 50 };
    const next = { name: 'Morlock', hp: 50 };
    const controller = { player: side === 'Enemy', currentPkmn: 0, team: [ewok, next] };
    const battle = { enemyName: 'Gorbertron' };
    const c = {
      whoAttacked: side, recoil, playerPkmn: player, enemyPkmn: ewok,
      playerDamage: 9.5, enemyDamage: 9.5, eRecoilDamage: 9.5, pRecoilDamage: 9.5,
      damageValue: 0, damaging: false, alarm: [], textList: [], currentText: 0,
      moveName: "Wicket's Reversal", enemyMoveName: "Wicket's Reversal",
      noone: -4, BattleEntityObject: 1, BattlePokemonObject: 2, BattleObject: { Fluxxed2: flux },
      instance_number: type => type === 1 ? 1 : 0,
      instance_find: type => type === 1 ? controller : battle,
      GetHealth: p => p.hp, GetName: p => p.name, GetLevel: () => 20,
      GetMoveCategory: () => 'Status', GetMoveEffect: () => 'None',
      GetEXPYield: () => 100, GetTrainerLoot: () => false, GetTrainerRank: () => 1,
      GetFirstHealthyPokemonExcept: () => 1, global: { pikminCount: 0 },
      ds_list_size: a => a.length, ds_list_find_value: (a, i) => a[i],
      ds_list_add: (a, ...v) => a.push(...v), ds_list_delete: (a, i) => a.splice(i, 1),
      string_concat: (...v) => v.join(''), max: Math.max, ceil: Math.ceil,
      string_count: (needle, text) => text.split(needle).length - 1,
      random_range: () => 1.1,
      DealDamage: (amount, fromPlayer) => {
        const target = fromPlayer ? ewok : player;
        target.hp = Math.max(0, target.hp - amount);
      },
    };
    vm.createContext(c);
    const run = code => vm.runInContext('(function() {\n' + adapt(code) + '\n})();', c);
    run(alarm);
    assert.equal(c.damageValue, flux ? 11 : 10);
    let ticks = 0;
    while (c.damaging && ticks++ < 30) run(tick);
    assert.equal(c.damaging, false, 'Fractional damage must finish animating');
    const target = side === 'Player' ? ewok : player;
    assert.equal(target.hp, Math.max(0, hp - (flux ? 11 : 10)));
    assert.equal(c.textList.some(text => text.includes('fainted')), hp === 10,
      'Fainting messages must agree with the actual HP result');
    if (hp === 10 && side === 'Player') {
      assert.equal(controller.currentPkmn, 1, 'Advance Gorbertron to the next Pokemon');
      assert(c.textList.includes('Gorbertron sent out Morlock'));
      assert(c.textList.includes('Your Pokemon gained 100 EXP'));
      if (!recoil && !flux) {
        // The attack has knocked out the opponent. Its faint/EXP/replacement
        // messages are pending while the attacker takes damage from a trap.
        c.textList.unshift('Your pokémon took some damage!');
        c.currentText = 0;
        c.whoAttacked = 'Enemy';
        c.recoil = true;
        controller.player = true;
        controller.currentPkmn = 0;
        controller.team = [player, next];
        const pending = [...c.textList];
        run(alarm);
        assert.deepEqual(c.textList, pending, 'Nonlethal trap damage preserves the opponent knockout');
        ticks = 0;
        while (c.damaging && ticks++ < 30) run(tick);
        assert(c.textList.includes('The opposing Ewok fainted'));
        assert(c.textList.includes('Gorbertron sent out Morlock'));
        // A simultaneous trap KO cancels later attacks without deleting the
        // other side's already pending knockout, EXP, or replacement.
        player.hp = 5;
        c.whoAttacked = 'Enemy';
        c.textList = ['Your pokémon took some damage!', 'Ally used Scratch.',
          'It deals 10 damage!', ...pending.slice(1)];
        run(alarm);
        assert(!c.textList.includes('Ally used Scratch.'));
        assert(!c.textList.includes('It deals 10 damage!'));
        assert(c.textList.includes('The opposing Ewok fainted'));
        assert(c.textList.includes('Your Pokemon gained 100 EXP'));
        assert(c.textList.includes('Gorbertron sent out Morlock'));
        assert(c.textList.includes('Ally fainted'));
      }
    }
  }
}
console.log('Fractional trap/recoil, exact knockout, surviving target, both sides, and Flux checks passed.');
