extends "standing_ability.gd"

# variables
var cost
var crest

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Trade health with opponent monster in pos.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    var monster = dungeon.get_tile(activate_dict["pos"]).content
    # negate abilities
    for ability in monster.card.abilities:
        ability.negate()
    # negate attack
    monster.attack_cooldown_behavior.max_attacks = 0

func get_select_tiles():
    return get_monsters_tiles()
