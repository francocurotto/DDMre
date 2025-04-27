extends RigidBody3D

#region constants
const THRES = 0.01
#endregion

#region signals
signal roll_stopped
#endregion

#region constants
const TYPECOLORS = {
	"DRAGON"      : Color(1.0, 0.0, 0.0),
	"SPELLCASTER" : Color(1.0, 1.0, 1.0),
	"UNDEAD"      : Color(1.0, 1.0, 0.0),
	"BEAST"       : Color(0.0, 1.0, 0.0),
	"WARRIOR"     : Color(0.0, 0.0, 1.0),
	"ITEM"        : Color(0.2, 0.2, 0.2)
}
#endregion

#region public variables
var rolling = false
#endregion

#region builtin functions
func _physics_process(_delta: float) -> void:
	# detect if dice stopped moving
	if rolling:
		if linear_velocity.length() <= THRES and angular_velocity.length() <= THRES:
			rolling = false
			roll_stopped.emit()
			for side in $Sides.get_children():
				if is_equal_approx(side.rotation.x, -PI/2):
					print(side.type + ", " + str(side.mult))
#endregion

#region public functions
func set_dice(dice_dict):
	var level = int(dice_dict["LEVEL"])
	var type = dice_dict["TYPE"]
	# set type
	set_dice_type(type)
	# set sides
	var side_strings = split_sides_string(dice_dict["CRESTS"])
	for i in 6:
		$Sides.get_child(i).set_side(level, side_strings[i])

func roll(velocity):
	rolling = true
	var force = 0.01 * Vector3(velocity.x, 0, velocity.y)
	var torque =  Vector3(randf_range(-5, 5), randf_range(-5, 5), randf_range(-5, 5))
	gravity_scale = 1 # activate gravity
	apply_central_impulse(force)
	apply_torque_impulse(torque)
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
