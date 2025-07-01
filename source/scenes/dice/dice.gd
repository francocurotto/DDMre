@tool
extends RigidBody3D
class_name Dice

#region signals
signal roll_stopped
signal dim_setup_finished
#endregion

#region enums
enum STATE {
	PREROLL,
	STARTROLL,
	ROLLING,
	POSTROLL
} 
#endregion

#region constants
const DIM_ROTATIONS = [
	Vector3(0,0,0),
	Vector3(PI/2,PI,0),
	Vector3(0,PI/2,-PI/2),
	Vector3(0,-PI/2,PI/2)
]
#endregion

#region export variables
@export var fade : bool = false :
	set(_fade):
		fade = _fade
		for side in $Sides.get_children():
			side.fade = fade
#endregion

#region public variables
var state = STATE.PREROLL
var rolled_side = null # resulted side after roll, null before roll
var moving : bool :
	get():
		return translating and rotating
#endregion

#region private variables
var dice_dict
var rotation_index
var translating : bool : 
	get(): 
		return linear_velocity.length() > 0.0001
var rotating : bool :
	get(): 
		return angular_velocity.length() > 0.0001
#endregion

#region onready variables
@onready var sides = $Sides
@onready var summon = $Summon
#endregion

#region builtin functions
func _physics_process(_delta: float) -> void:
	# if roll started and move detected, switch to rolling
	if state == STATE.STARTROLL:
		if moving:
			state = STATE.ROLLING
	# detect if dice stopped moving
	elif state == STATE.ROLLING:
		if not moving:
			state = STATE.POSTROLL
			rolled_side = get_rolled_side()
			roll_stopped.emit()
#endregion

#region public functions
func set_dice(_dice_dict):
	dice_dict = _dice_dict
	var level = int(dice_dict["LEVEL"])
	var type = dice_dict["TYPE"]
	# set sides
	var side_strings = split_sides_string(dice_dict["CRESTS"])
	for i in 6:
		$Sides.get_child(i).set_side(type, level, side_strings[i])
	# set summon
	$Summon.set_summon(dice_dict)

func clone():
	var copy = duplicate()
	copy.set_dice(dice_dict)
	return copy

func roll(velocity):
	state = STATE.STARTROLL
	rolled_side = null
	var force = 0.01 * Vector3(velocity.x, 0, velocity.y)
	var torque = Vector3(randf_range(-5, 5), randf_range(-5, 5), randf_range(-5, 5))
	gravity_scale = 1 # activate gravity
	apply_central_impulse(force)
	apply_torque_impulse(torque)

func remove():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector3.ZERO, 1)
	await tween.finished
	queue_free()

func setup_dim_select(new_position):
	gravity_scale = 0 # disable gravity
	var tween = create_tween()
	tween.tween_property(self, "position", new_position, 1)
	var index = rolled_side.get_index()
	var dim_rotation = DIM_ROTATIONS[index]
	tween.parallel().tween_property(self, "rotation", dim_rotation, 1)
	await tween.finished
	dim_setup_finished.emit()
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

func get_rolled_side():
	for side in $Sides.get_children():
		var facing_direction = side.global_transform.basis.z
		var dot = facing_direction.dot(Vector3.UP)
		if dot > 0.95:
			return side
#endregion
