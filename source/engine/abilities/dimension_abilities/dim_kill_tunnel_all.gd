extends "res://engine/abilities/dim_manual_ability.gd"

var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    summon.player.crestpool.remove_crests(CREST, COST)
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.has_active_ability("TUNNEL"):
            dungeon_monster.destroy()
