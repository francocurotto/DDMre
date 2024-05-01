extends "cast_ability.gd"
## TRADEHEALTH ability.
##
## Inflict a certain amount of damage to an opponent monster, and this monster.

#region variables
var amount ## Amount of damage to inflict to both monsters
var cost   ## Cost to pay to activate abililty
var crest  ## Crest type to pay to activate ability
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability using parameters [param activate_dict]. Inflict damage to 
## both monsters.
func activate(activate_dict):
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    monster.receive_damage(amount)
    summon.receive_damage(amount)

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_opponent_monsters_tiles()
#endregion
