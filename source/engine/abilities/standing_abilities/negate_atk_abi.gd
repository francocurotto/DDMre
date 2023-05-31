extends "standing_ability.gd"

# variables
var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Trade health with opponent monster in pos.
    """
    monster.player.crestpool.remove_crests(CREST, COST)
    var monster = dungeon.get_tile(activate_dict["pos"]).content
    # negate abilities
    for ability in monster.card.abilities:
        ability.negate()
    # negate attack
    monster.attack_cooldown_behavior.max_attacks = 0

func get_select_tiles():
    return get_monsters_tiles()
