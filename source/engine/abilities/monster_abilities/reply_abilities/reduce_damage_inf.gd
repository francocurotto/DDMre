extends "reply_ability.gd"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate(_attacker, activate_dict):
    """
    Add temporal reduce to damage behavior.
    """
    super.activate(_attacker, activate_dict)
    var reduce = activate_dict["reduce"]
    pay_crests("DEFENSE", reduce)
    summon.damage_behavior.ability_reduce += 10*reduce

func deactivate():
    super.deactivate()
    summon.damage_behavior.ability_reduce = 0
