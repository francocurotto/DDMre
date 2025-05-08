@tool
extends HBoxContainer

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

func create_icon():
	var icon = TextureRect.new()
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.custom_minimum_size = Vector2(24,24)
	return icon
#endregion
