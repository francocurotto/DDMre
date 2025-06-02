extends Node3D

#region constants
const DIMDICE_POS = Vector3(0, 1, -3)
#endregion

#region private variables
var dimdice = null
#endregion

#region builtin functions
func _ready() -> void:
	Events.dimdice_selected.connect(on_dimdice_selected)
#endregion

#region signals callbacks
func on_dimdice_selected(new_dimdice):
	# remove previous dimdice
	if dimdice:
		dimdice.queue_free()
	# add dimdice to tree
	dimdice = new_dimdice
	add_child(dimdice)
	dimdice.position = DIMDICE_POS
#endregion
