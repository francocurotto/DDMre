extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(_monster, dungeon):
    for row in dungeon.array:
        for tile in row:
            var dungobj = tile.content
            if dungobj.is_monster(): # TODO: change for vortex?
                dungobj.die()
            elif dungobj.is_item():
                tile.empty_tile()
