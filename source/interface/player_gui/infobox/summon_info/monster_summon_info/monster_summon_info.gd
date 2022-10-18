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
func set_info(kwargs):
    var monster = kwargs["monster"]
    var target = kwargs["target"]
    var power = get_power(monster, target)
    attack_value.text = str(power)
    attack_value.modulate = MODDICT[sign(power-monster.card.attack)]
    defense_value.text = str(monster.defense)
    defense_value.modulate = MODDICT[sign(monster.defense-monster.card.defense)]
    currhealth_value.text = str(monster.health)
    currhealth_value.modulate = MODDICT[sign(monster.health-monster.card.health)]
    health_value.text = str(monster.card.health)

func get_power(monster, target):
    if not target:
        return monster.attack
    return monster.get_power(target)
