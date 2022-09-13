extends MarginContainer

# constants
const MODDICT = { 1.0 : Color(0.5,1.0, 1.0, 1.0), 
                 -1.0 : Color(1.0,0.75,0.75,1.0),
                  0.0 : Color(1.0,1.0, 1.0, 1.0)}

# onready variables
onready var monstername = $MonsterBox/MonsterName
onready var type        = $MonsterBox/MonsterStats/TLA/Type
onready var level       = $MonsterBox/MonsterStats/TLA/Level
onready var ability     = $MonsterBox/MonsterStats/TLA/Ability
onready var attack      = $MonsterBox/MonsterStats/Attack/AttackValue
onready var defense     = $MonsterBox/MonsterStats/Defense/DefenseValue
onready var health      = $MonsterBox/MonsterStats/Health/HealthValue

# set functions
func set_attack_monster(monster):
    monstername.text = monster.card.name
    type.texture = load("res://art/icons/TYPE_" + monster.card.type + ".png")
    level.text = str(monster.card.level)
    # no ability icon
    if monster.card.ability.empty():
        ability.texture = null
    # ability icon
    else:
        ability.texture = load("res://art/icons/ABILITY.png")
    # monster info
    attack.text = str(monster.attack)
    attack.modulate = MODDICT[sign(monster.attack-monster.card.attack)]
    defense.text = str(monster.defense)
    defense.modulate = MODDICT[sign(monster.defense-monster.card.defense)]
    health.text = str(monster.health)
    health.modulate = MODDICT[sign(monster.health-monster.card.health)]

func set_attacker_power(attacker, attacked):
    var power = attacker.get_power(attacked)
    attack.text = str(power)
    attack.modulate = MODDICT[sign(power-attacker.card.attack)]
