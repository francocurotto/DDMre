extends "reply_ability.gd"
## SHIFTDAMAGE ability.
##
## Shift damage inflicted by an attack to a different player monster.

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
## Activate ability. Shift damage to other monster by changing the receiver 
## variable in the damage behavior. The receiver monster is defined by a 
## position in [activate_dict].
func activate(_attacker, activate_dict):
    super(_attacker, activate_dict)
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var receiver = dungeon.get_tile(pos).content
    summon.damage_behavior.receiver = receiver

## Deactivate ability. Return receiver variable to original monster.
func deactivate():
    super()
    summon.damage_behavior.receiver = summon

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_player_other_monsters_tiles()
#endregion
