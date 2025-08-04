@tool
extends HBoxContainer

#region export variables
@export_range(10, 60, 10) var health : int = 10 :
	set(_health):
		health = _health
		# remove previous hearts
		for icon in get_children():
			icon.queue_free()
		# add hearts
		@warning_ignore("integer_division")
		for i in health/10:
			var icon = create_icon()
			add_child(icon)

func create_icon():
	var icon = TextureRect.new()
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.custom_minimum_size = Vector2(24,24)
	icon.texture = load("res://assets/ATTR_HEALTH.svg")
	return icon
#endregion
