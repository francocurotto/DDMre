extends HBoxContainer

# constants
const MODDICT = { 1.0 : Color(0.5,1.0, 1.0, 1.0), 
                 -1.0 : Color(1.0,0.75,0.75,1.0),
                  0.0 : Color(1.0,1.0, 1.0, 1.0)}

# onready variables
onready var attack_value = $Attack/AttackValue
onready var defense_value = $Defense/DefenseValue
onready var currhealth_value = $Health/CurrHealthValue
onready var health_value = $Health/HealthValue

# set functions
func set_monster_summon_info(summon):
    attack_value.text = str(summon.attack)
    attack_value.modulate = MODDICT[sign(summon.attack-summon.card.attack)]
    defense_value.text = str(summon.defense)
    defense_value.modulate = MODDICT[sign(summon.defense-summon.card.defense)]
    currhealth_value.text = str(summon.health)
    currhealth_value.modulate = MODDICT[sign(summon.health-summon.card.health)]
    health_value.text = str(summon.card.health)
