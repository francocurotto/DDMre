extends "res://engine/abilities/monster_abilities/monster_ability.gd"
## Ability activated when a monster is attacked.

#region constants
const TYPE = "REPLY"
#endregion

#region public functions
## When ability is activated, connect deactivation of ability with the end of 
## attack.
func activate(_attacker, _activate_dict):
    summon.connect("attack_ends", Callable(self, "deactivate"))

## Deactivate ability when attack ends. Disconnect ability so that is not 
## further activated during future attacks.
func deactivate():
    summon.disconnect("attack_ends", Callable(self, "deactivate"))
#endregion
