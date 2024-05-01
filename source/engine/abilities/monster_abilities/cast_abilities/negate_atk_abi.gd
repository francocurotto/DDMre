extends "cast_ability.gd"
## NEGATEATKABI ability.
##
## Negate attacks and abilities of a monster for the rest of the duel.

#region variables
var cost  ## Cost to pay to activate abililty
var crest ## Crest type to pay to activate ability
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability using parameters [param activate_dict]. Negate attacks and
## abilities of a monster.
func activate(activate_dict):
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    # negate abilities
    monster.negate_abilities()
    # negate attack
    monster.attack_cooldown_behavior.max_attacks = 0

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_monsters_tiles()
#endregion
