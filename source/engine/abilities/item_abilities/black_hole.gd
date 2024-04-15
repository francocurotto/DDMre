extends "item_ability.gd"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate(_monster):
    for _summon in dungeon.summons:
        _summon.destroy()
