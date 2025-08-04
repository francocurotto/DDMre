@tool
extends Node3D

#region constants
const PIXEL_SIZE = 0.0004
#endregion

#region export variables
@export_range(0, 60, 10) var health : int = 10 :
	set(_health):
		health = _health
		set_hearts_icons()

@export_range(0, 60, 10) var original_health : int = 10 :
	set(_original_health):
		original_health = _original_health
		health = original_health
		set_hearts_icons()
#endregion

#region private functions
func set_hearts_icons():
	# remove previous hearts
	for icon in get_children():
		icon.queue_free()
	@warning_ignore("integer_division")
	for i in original_health/10:
		var icon = create_icon()
		@warning_ignore("integer_division")
		if i <= (health/10)-1:
			icon.texture = load("res://assets/ATTR_HEALTH.svg")
		else:
			icon.texture = load("res://assets/ATTR_NOHEALTH.svg")
		add_child(icon)
		icon.position.x = 0.2*i

func create_icon():
	var icon = Sprite3D.new()
	icon.pixel_size = PIXEL_SIZE
	return icon
#endregion
