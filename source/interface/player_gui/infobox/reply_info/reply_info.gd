extends MarginContainer

# variables
var enabled = false

onready var attacker_info = {
    "name"    : $ReplyBox/AttackerName,
    "type"    : $ReplyBox/AttackerStats/TLA/Type,
    "level"   : $ReplyBox/AttackerStats/TLA/Level,
    "ability" : $ReplyBox/AttackerStats/TLA/Ability,
    "attack"  : $ReplyBox/AttackerStats/Attack/AttackValue,
    "defense" : $ReplyBox/AttackerStats/Defense/DefenseValue,
    "health"  : $ReplyBox/AttackerStats/Health/HealthValue}
onready var attacked_info = {
    "name"    : $ReplyBox/AttackedName,
    "type"    : $ReplyBox/AttackedStats/TLA/Type,
    "level"   : $ReplyBox/AttackedStats/TLA/Level,
    "ability" : $ReplyBox/AttackedStats/TLA/Ability,
    "attack"  : $ReplyBox/AttackedStats/Attack/AttackValue,
    "defense" : $ReplyBox/AttackedStats/Defense/DefenseValue,
    "health"  : $ReplyBox/AttackedStats/Health/HealthValue}


# signals
signal guard_input
signal wait_input

# set functions
func set_reply(reply_state):
    set_reply_monster(reply_state.attacker, attacker_info)
    set_reply_monster(reply_state.attacked, attacked_info)

# signals callback
func _on_GuardButton_pressed():
    emit_signal("guard_input")

func _on_WaitButton_pressed():
    emit_signal("wait_input")

# private functions
func set_reply_monster(monster, monster_info):
    monster_info["name"].text = monster.card.name
    monster_info["type"].texture = load("res://art/icons/TYPE_" + monster.card.type + ".png")
    monster_info["level"].text = str(monster.card.level)
    # no ability icon
    if monster.card.ability.empty():
        monster_info["ability"].texture = null
    # ability icon
    else:
        monster_info["ability"].texture = load("res://art/icons/ABILITY.png")
    # monster info
    monster_info["attack"].text = str(monster.card.attack)+"/"+str(monster.attack)
    monster_info["defense"].text = str(monster.card.defense)+"/"+str(monster.defense)
    monster_info["health"].text = str(monster.card.health)+"/"+str(monster.health)
