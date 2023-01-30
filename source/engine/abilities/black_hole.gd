extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(_monster, dungeon):
    for row in dungeon.array:
        for tile in row:
            if tile.content.is_summon(): # TODO: change for vortex?
                tile.empty_tile()
