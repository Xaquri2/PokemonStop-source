# Online battle feasibility

Investigated October 31, 2026. This is a design investigation; no game or
production-server behavior was changed.

## Conclusion

Internet player-versus-player battles are feasible. Papercomputergames.com can
serve as the account/lobby entry point and host a separate battle API. The
largest work is extracting battle resolution from GameMaker's presentation and
single-player progression, rather than transmitting moves over the internet.

Start with private, unranked, invite-code battles. Use a server-authoritative
turn resolver and temporary team copies. Add account linking and public
matchmaking after the battle loop is reliable.

## Evidence from this project

- `objects/BattleMenuObject/Step_0.gml` chooses enemy moves with `ChooseMove`,
  determines action order, rolls outcomes, consumes PP, applies effects, and
  builds text. Online input cannot safely be substituted in just one location:
  attack, escape, and other branches have their own resolution paths.
- `scripts/BattleFunctions/BattleFunctions.gml` contains reusable rules, but
  `GetDamage` looks up live `BattlePokemonObject` instances. Effects also refer
  to `BattleObject` and `BattleTextboxObject`. These functions are not yet an
  independent simulation engine.
- `objects/BattleTextboxObject/Alarm_2.gml` interprets text such as "used" and
  "poison damage" to drive battle behavior. Its Step event awards experience
  and processes level-up learning. Presentation must become a consumer of typed
  battle events rather than a source of authoritative state changes.
- `objects/BattleObject/Create_0.gml` aliases `global.playerParty` directly.
  Online battles need deep copies, including nested move and PP lists.
- `objects/BattleObject/Destroy_0.gml` records beaten trainers and restores world
  state. PvP needs a separate exit path that cannot trigger story rewards,
  trainer flags, defeat penalties, inventory changes, or save mutations.
- `scripts/PokemonFunctions/PokemonFunctions.gml` stores Pokemon in positional
  DS lists including sprite assets. Network records should use named fields
  and stable species/move IDs, never runtime instance, asset, or DS-list IDs.
- `scripts/DataFunctions/DataFunctions.gml` already serializes local JSON saves.
  This provides useful conversion patterns, but a full save is neither an
  appropriate battle payload nor proof that an imported team is legitimate.
- A search of scripts and objects found no existing `http_`, `network_`, or
  `async_load` integration. Networking and authentication would be new systems.
- Existing tests adapt selected GML functions into JavaScript. They do not run
  an entire battle or compile the GameMaker project.

## PCG hosting observations

Read-only inspection of the existing `pcg` SSH host confirmed Linux, Node.js,
Nginx, and a running PM2 service. Nginx routes papercomputergames.com and www to
the existing application on localhost port 3000. The host reported about 2 GB
RAM, roughly 1.2 GB available memory, and 27 GB free disk at inspection time.

These are promising conditions for a small pilot, not a concurrency guarantee.
No load test was performed. Existing account/session internals were not audited;
the public website has a login entry point, but reusable game authentication
still needs verification. Existing Node v18.19.1 was observed; choose a supported
runtime for the new service after checking current deployment compatibility.

Run the battle service as a separate supervised process bound to localhost,
with Nginx forwarding a proposed `/api/battles/` prefix to it. Keep the existing
website available independently. Persist match snapshots, accepted commands,
and results so a service restart does not silently lose active battles.

## Recommended player experience

1. Open Online Battle from a safe place in the game.
2. Select a team; the game creates an isolated battle copy.
3. Create a room and share a short invite code, or join with a code.
4. Both players confirm the rules and ready up.
5. Each privately chooses a move or switch. The server resolves the turn only
   after receiving all required choices, then both clients animate its events.
6. Show the result and return to the game with the story party unchanged.

First ruleset: singles, up to six Pokemon, restored HP/PP, no bag items,
catching, XP, money, story flags, or ranked rewards. Treat Run as an explicit
forfeit. Define level normalization and supported species/moves before release;
reject unsupported content rather than silently changing its behavior.

## Connection and authority

For the first implementation, use HTTPS JSON requests with short polling while
waiting for the other player (for example, once per second with backoff).
Turn-based battles do not require a continuous stream of movement packets.
GameMaker supports custom HTTP headers, bodies, and asynchronous responses.
If browser exports are supported later, validate cross-origin behavior too.

Both clients make outbound HTTPS connections to PCG. Players do not need to
forward ports or expose their IP addresses to each other. WebSockets can be
evaluated later for immediate notifications; they are not needed for the pilot.

The server owns HP, PP, status, stat stages, field effects, action order, all
random rolls, legal choices, and the final outcome. Clients send intent, not
damage or a claimed win. Keep choices hidden until resolution, and return only
the opponent information the rules permit each player to see.

Do not simply give both existing clients the same random seed: animation-driven
state changes and unrelated RNG calls can still diverge. Likewise, a relay that
trusts one player's computed result is suitable only for a disposable friendly
prototype, not a foundation for fair public play.

Proposed API operations (not existing endpoints):

| Operation | Purpose |
| --- | --- |
| Create / join room | Issue separate scoped participant sessions |
| Submit team / ready | Validate and lock team plus rules version |
| Submit action | Accept one legal command for the expected decision phase |
| Fetch updates after sequence | Deliver unseen events and current revision |
| Resume | Return an authorized snapshot and subsequent events |
| Forfeit | Record a terminal outcome exactly once |

Every action includes match ID, decision/turn ID, expected revision, and a unique
command ID. Duplicate retries return the earlier acknowledgement; stale choices
are rejected. Process concurrent submissions atomically. Forced replacement
after fainting is a distinct decision phase, not an ordinary attack turn.

Use high-entropy participant tokens over HTTPS. Invite codes locate a room;
they must not grant control of an existing player. Rate-limit joins and commands,
limit payload size, and expire abandoned rooms. For website account linking,
prefer a short-lived browser-approved pairing flow so the game never handles a
website password; exact integration depends on the existing account system.

Validate species, level, move legality, party limits, and build/rules versions.
Recompute stats on the server. A legal-looking local save still cannot prove a
Pokemon was earned legitimately. Use normalized or supplied teams for future
ranked play unless progression becomes server-managed.

## Implementation sequence and release gates

1. **Extract the battle model.** Define serializable state, legal commands,
   explicit decision phases, and typed events. Remove dependencies on text,
   sprites, instance IDs, and animation timing from resolution. Preserve current
   single-player rules through representative battle fixtures.
2. **Build the authoritative resolver.** A Node service fits the existing host,
   but GML cannot simply be imported into Node. Port rules and export versioned
   species/move data, with fixtures comparing the port against the game. Begin
   with an explicitly limited ruleset if full move coverage is too large.
3. **Prove transport on staging.** Two real game clients create/join a room,
   send choices, and consume the same server result. Verify GameMaker's actual
   target runtime, certificates, headers, async request routing, and timeouts.
4. **Add resilience and safe exits.** Reconnect tokens, durable snapshots,
   duplicate suppression, decision deadlines, disconnect grace periods, and
   exactly-once results. Define whether a timed-out player forfeits; distinguish
   this from a server outage, which should not award an arbitrary win.
5. **Pilot private battles, then add PCG account linking and matchmaking.**
   Avoid introducing ranking before correctness and team policy are settled.

Required battle fixtures include priority and speed ties, PP exhaustion,
Struggle, status and residual damage, recoil/double knockouts, switches, forced
replacements, field effects, and special move behavior. Network checks include
simultaneous submissions, stale/duplicate actions, a disconnect mid-turn,
resume during animation, server restart, mismatched builds, and attempted
opponent-session access. Verify story saves and nested party data remain
unchanged after wins, losses, forfeits, and connection failures.

This is a substantial feature, not a small networking patch. The next useful
implementation milestone is one complete two-client battle with a small,
documented move set on staging. Estimate the full project after that slice
reveals the cost of disentangling and matching current battle behavior.

## External references

- GameMaker HTTP request API:
  https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Reference/Asynchronous_Functions/HTTP/http_request.htm
- GameMaker asynchronous HTTP lifecycle and cross-domain notes:
  https://manual.gamemaker.io/beta/en/GameMaker_Language/GML_Reference/Asynchronous_Functions/HTTP/HTTP.htm
- Public PCG website: https://papercomputergames.com/
