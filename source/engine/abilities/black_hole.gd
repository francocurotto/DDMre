extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(_monster, dungeon):
    for tile in dungeon.tiles:
        var dungobj = tile.content
        if dungobj.is_summon():
            dungobj.die()
