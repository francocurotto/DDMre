extends HBoxContainer

# onready variables
onready var attack_value = $Attack/AttackValue
onready var defense_value = $Defense/DefenseValue
onready var health_value = $Health/HealthValue

# setget functions
func set_info(kwargs):
    var card = kwargs["card"]
    attack_value.text = str(card.attack)
    defense_value.text = str(card.defense)
    health_value.text = str(card.health)
