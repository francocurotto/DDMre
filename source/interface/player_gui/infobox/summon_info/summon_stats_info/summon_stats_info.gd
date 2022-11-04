extends HBoxContainer

# constants
const MODDICT = { 1.0 : Color(0.5,1.0, 1.0, 1.0), 
                 -1.0 : Color(1.0,0.75,0.75,1.0),
                  0.0 : Color(1.0,1.0, 1.0, 1.0)}

# onready variables
onready var attack = $Attack
onready var defense = $Defense
onready var health = $Health

# setget functions
func set_info(kwargs):
    var monster = kwargs["monster"]
    var target = kwargs["target"]
    var power = get_power(monster, target)
    attack.set_dice_stat("ATTACK", power)
    attack.modulate_value(MODDICT[sign(power-monster.card.attack)])
    defense.set_dice_stat("DEFENSE", monster.defense)
    defense.modulate_value(MODDICT[sign(monster.defense-monster.card.defense)])
    health.set_health(monster)
    health.modulate_value(MODDICT[sign(monster.health-monster.card.health)])

# private functions
func get_power(monster, target):
    if not target:
        return monster.attack
    return monster.get_power(target)
