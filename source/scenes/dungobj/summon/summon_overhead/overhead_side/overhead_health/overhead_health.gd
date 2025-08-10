@tool
extends Node3D

#region constants
const PIXEL_SIZE = 0.0004
#endregion

#region public variables
var alpha : float = 1.0 :
	set(_alpha):
		alpha = _alpha
		for heart in get_children():
			heart.modulate.a = alpha
#endregion

#region private functions
func set_value(original_health, health):
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
	icon.double_sided = false
	return icon
#endregion
