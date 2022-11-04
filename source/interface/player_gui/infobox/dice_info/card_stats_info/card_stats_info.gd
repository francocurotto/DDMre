extends HBoxContainer

# onready variables
onready var attack = $Attack
onready var defense = $Defense
onready var health = $Health

# setget functions
func set_info(kwargs):
    var card = kwargs["card"]
    attack.set_dice_stat("ATTACK", card.attack)
    defense.set_dice_stat("DEFENSE", card.defense)
    health.set_dice_stat("HEALTH", card.health)
