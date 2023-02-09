extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func summon_activate():
    var pos = dungeon.get_dungobj_pos(summon)
    var tile = dungeon.get_tile(pos)
    summon.die()
    tile.vortex = true

