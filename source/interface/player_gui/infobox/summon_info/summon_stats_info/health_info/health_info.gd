extends HBoxContainer

# onready variables
onready var current_health = $CurrentHealth
onready var health = $Health

# set functions
func set_health(monster):
    current_health.text = str(monster.health)
    health.text = str(monster.card.health)

func modulate_value(color):
    current_health.modulate = color
