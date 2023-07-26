extends VBoxContainer

# onready variables
onready var attacker_info = $AttackerInfo
onready var attacked_info = $AttackedInfo

# setget functions
func set_summons(attacker, player, attacked, opponent):
    attacker_info.set_summon(attacker, player)
    attacked_info.set_summon(attacked, opponent)
    attacker_info.set_attacker_power(attacker, attacked)
