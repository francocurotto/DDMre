extends Node

#region POOLPATHS
#const POOL1PATH = "res://databases/dicepools/debug/test1.json";
#const POOL1PATH = "res://databases/dicepools/debug/long_abilities.json";
#endregion

#region DUNGPATHS
#const DUNGPATH = "res://databases/dungeons/debug/test1.json";
const DUNGPATH = "res://databases/dungeons/ability_tests/pass.json";                const POOL1PATH = "res://databases/dicepools/ability_tests/pass.json";                const POOL2PATH = "res://databases/dicepools/ability_tests/pass.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/target.json";              const POOL1PATH = "res://databases/dicepools/ability_tests/target.json";              const POOL2PATH = "res://databases/dicepools/ability_tests/target.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/power.json";               const POOL1PATH = "res://databases/dicepools/ability_tests/power.json";               const POOL2PATH = "res://databases/dicepools/ability_tests/power.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/move.json";                const POOL1PATH = "res://databases/dicepools/ability_tests/move.json";                const POOL2PATH = "res://databases/dicepools/ability_tests/move.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/items.json";               const POOL1PATH = "res://databases/dicepools/ability_tests/items.json";               const POOL2PATH = "res://databases/dicepools/ability_tests/items.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/dim_abilities.json";       const POOL1PATH = "res://databases/dicepools/ability_tests/dim_abilities.json";       const POOL2PATH = "res://databases/dicepools/ability_tests/dim_abilities.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/dim_buff_dead_type.json";  const POOL1PATH = "res://databases/dicepools/ability_tests/dim_buff_dead_type.json";  const POOL2PATH = "res://databases/dicepools/ability_tests/dim_buff_dead_type.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/exodia.json";              const POOL1PATH = "res://databases/dicepools/ability_tests/exodia.json";              const POOL2PATH = "res://databases/dicepools/ability_tests/exodia.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/buff_type.json";           const POOL1PATH = "res://databases/dicepools/ability_tests/buff_type.json";           const POOL2PATH = "res://databases/dicepools/ability_tests/buff_type.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/stops.json";               const POOL1PATH = "res://databases/dicepools/ability_tests/stops.json";               const POOL2PATH = "res://databases/dicepools/ability_tests/stops.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/protect_type.json";        const POOL1PATH = "res://databases/dicepools/ability_tests/protect_type.json";        const POOL2PATH = "res://databases/dicepools/ability_tests/protect_type.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/turn_slow_type.json";      const POOL1PATH = "res://databases/dicepools/ability_tests/turn_slow_type.json";      const POOL2PATH = "res://databases/dicepools/ability_tests/turn_slow_type.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/vortex.json";              const POOL1PATH = "res://databases/dicepools/ability_tests/vortex.json";              const POOL2PATH = "res://databases/dicepools/ability_tests/vortex.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/raise_attack.json";        const POOL1PATH = "res://databases/dicepools/ability_tests/raise_attack.json";        const POOL2PATH = "res://databases/dicepools/ability_tests/raise_attack.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/reduce_damage.json";       const POOL1PATH = "res://databases/dicepools/ability_tests/reduce_damage.json";       const POOL2PATH = "res://databases/dicepools/ability_tests/reduce_damage.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/reply_abilities.json";     const POOL1PATH = "res://databases/dicepools/ability_tests/reply_abilities.json";     const POOL2PATH = "res://databases/dicepools/ability_tests/reply_abilities.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/buff_self.json";           const POOL1PATH = "res://databases/dicepools/ability_tests/buff_self.json";           const POOL2PATH = "res://databases/dicepools/ability_tests/buff_self.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/buff_damage.json";         const POOL1PATH = "res://databases/dicepools/ability_tests/buff_damage.json";         const POOL2PATH = "res://databases/dicepools/ability_tests/buff_damage.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/distance_attack.json";     const POOL1PATH = "res://databases/dicepools/ability_tests/distance_attack.json";     const POOL2PATH = "res://databases/dicepools/ability_tests/distance_attack.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/range_kill_all.json";      const POOL1PATH = "res://databases/dicepools/ability_tests/range_kill_all.json";      const POOL2PATH = "res://databases/dicepools/ability_tests/range_kill_all.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/trade_health.json";        const POOL1PATH = "res://databases/dicepools/ability_tests/trade_health.json";        const POOL2PATH = "res://databases/dicepools/ability_tests/trade_health.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/steal_monster.json";       const POOL1PATH = "res://databases/dicepools/ability_tests/steal_monster.json";       const POOL2PATH = "res://databases/dicepools/ability_tests/steal_monster.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/mind_control.json";        const POOL1PATH = "res://databases/dicepools/ability_tests/mind_control.json";        const POOL2PATH = "res://databases/dicepools/ability_tests/mind_control.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/kill_block.json";          const POOL1PATH = "res://databases/dicepools/ability_tests/kill_block.json";          const POOL2PATH = "res://databases/dicepools/ability_tests/kill_block.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/range_level_kill.json";    const POOL1PATH = "res://databases/dicepools/ability_tests/range_level_kill.json";    const POOL2PATH = "res://databases/dicepools/ability_tests/range_level_kill.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/roll_level_kill.json";     const POOL1PATH = "res://databases/dicepools/ability_tests/roll_level_kill.json";     const POOL2PATH = "res://databases/dicepools/ability_tests/roll_level_kill.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/dim_kill_tunnel_all.json"; const POOL1PATH = "res://databases/dicepools/ability_tests/dim_kill_tunnel_all.json"; const POOL2PATH = "res://databases/dicepools/ability_tests/dim_kill_tunnel_all.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/dim_trade_crest.json";     const POOL1PATH = "res://databases/dicepools/ability_tests/dim_trade_crest.json";     const POOL2PATH = "res://databases/dicepools/ability_tests/dim_trade_crest.json"
#const DUNGPATH = "res://databases/dungeons/default.json";                           const POOL1PATH = "res://databases/dicepools/ability_tests/dim_kill_tunnel.json";     const POOL2PATH = "res://databases/dicepools/ability_tests/dim_kill_tunnel.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/dim_kill_weakest.json";    const POOL1PATH = "res://databases/dicepools/ability_tests/dim_kill_weakest.json";    const POOL2PATH = "res://databases/dicepools/ability_tests/dim_kill_weakest.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/monster_reborn.json";      const POOL1PATH = "res://databases/dicepools/ability_tests/monster_reborn.json";      const POOL2PATH = "res://databases/dicepools/ability_tests/monster_reborn.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/dim_cure.json";            const POOL1PATH = "res://databases/dicepools/ability_tests/dim_cure.json";            const POOL2PATH = "res://databases/dicepools/ability_tests/dim_cure.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/multi_attack.json";        const POOL1PATH = "res://databases/dicepools/ability_tests/multi_attack.json";        const POOL2PATH = "res://databases/dicepools/ability_tests/multi_attack.json"
#const DUNGPATH = "res://databases/dungeons/ability_tests/negate_atk_abi.json";      const POOL1PATH = "res://databases/dicepools/ability_tests/negate_atk_abi.json";      const POOL2PATH = "res://databases/dicepools/ability_tests/negate_atk_abi.json"
#endregion
