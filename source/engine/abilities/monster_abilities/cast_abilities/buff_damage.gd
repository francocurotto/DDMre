extends "cast_ability.gd"
## BUFFDAMAGE ability.
##
## Buff monster attribute in an amount equivalent to the damage in monster.

#region variables
var attr   ## Monster attribute to buff
var cost   ## Cost to pay to activate abililty
var crest  ## Crest type to pay to activate ability
#endregion

#region builtin function
func _init(ability_dict):
    super(ability_dict)
    attr = ability_dict["ATTR"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability. Buff monster attribute by damage.
func activate(_activate_dict):
    pay_crests(crest, cost)
    var damage = summon.card.health - summon.health
    summon.buff_attr(attr, damage)
#endregion
