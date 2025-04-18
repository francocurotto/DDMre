extends RigidBody3D

#region constants
const TYPECOLORS = {
	"DRAGON"      : Color(1.0, 0.0, 0.0),
	"SPELLCASTER" : Color(0.7, 0.7, 0.7),
	"UNDEAD"      : Color(1.0, 1.0, 0.0),
	"BEAST"       : Color(0.0, 1.0, 0.0),
	"WARRIOR"     : Color(0.0, 0.0, 1.0),
	"ITEM"        : Color(0.1, 0.1, 0.1)
}
#endregion

#region public functions
func set_dice(dice_dict):
	var level = int(dice_dict["LEVEL"])
	var type = dice_dict["TYPE"]
	print(type)
	# set type
	set_dice_type(type)
	# set sides
	var side_strings = split_sides_string(dice_dict["CRESTS"])
	for i in 6:
		$Sides.get_child(i).set_side(level, side_strings[i])

func roll_dice():
	var random_force = Vector3(randf_range(-5, 5), randf_range(5, 10), randf_range(-5, 5))
	var random_torque = Vector3(randf_range(-5, 5), randf_range(-5, 5), randf_range(-5, 5))

	apply_central_impulse(random_force)  # Push the dice
	apply_torque_impulse(random_torque)  # Add spin
#endregion

#region private functions
func split_sides_string(sides_string):
	# prepare regex for side string separation
	var regex = RegEx.new()
	regex.compile("S|[MADTG][1-9]?") # regex for side detection

	# create list of side strings
	var side_strings = []
	for result in regex.search_all(sides_string):
		side_strings.append(result.get_string())
	return side_strings

func set_dice_type(type):
	var material = $MeshInstance3D.get_surface_override_material(0)
	material = material.duplicate()
	$MeshInstance3D.set_surface_override_material(0, material)
	material.albedo_color = TYPECOLORS[type]
#endregion
