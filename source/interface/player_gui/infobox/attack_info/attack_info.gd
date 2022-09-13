extends MarginContainer

# onready variables
onready var attacker_info = $AttackBox/AttackerInfo
onready var attacked_info = $AttackBox/AttackedInfo

# set functions
func set_attack(attacker, attacked):
    attacker_info.set_attack_monster(attacker)
    attacked_info.set_attack_monster(attacked)
    attacker_info.set_attacker_power(attacker, attacked)
