@tool
extends RigidBody3D
class_name Dice

#region constants
const STATIC_LINEAR_VELOCITY_THRESHOLD = 0.001
const STATIC_ANGULAR_VELOCITY_THRESHOLD = 0.01
const STATIC_TIME_THRESHOLD = 0.5
const ROLLED_SIDE_THRESHOLD = 0.99
const ROLL_FORCE_SCALER = 0.01
const ROLL_TORQUE_LIMIT = 5
#endregion

#region signals
signal dice_stopped
signal dim_setup_finished
signal dice_rotation_finished
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
@export var highlight : bool = false :
	set(_highlight):
		highlight = _highlight
		for side in $Sides.get_children():
			side.highlight = highlight
#endregion

#region public variables
var sides = []
var rolled_side :
	get():
		for side in sides:
			var facing_direction = side.global_transform.basis.z
			if facing_direction.dot(Vector3.UP) > ROLLED_SIDE_THRESHOLD:
				return side
var moving : bool :
	get():
		return translating or rotating
#endregion

#region private variables
var dice_dict # copy of dice data needed when duplicating
var rollable = false
var static_time = 0.0
var quaternion_from # origin quaternion for rotation tween
var basis_to = basis # end basis for roation tween
var translating : bool : 
	get(): 
		return linear_velocity.length() > STATIC_LINEAR_VELOCITY_THRESHOLD
var rotating : bool :
	get(): 
		return angular_velocity.length() > STATIC_ANGULAR_VELOCITY_THRESHOLD
#endregion

#region onready variables
@onready var side1 = $Sides/Side1
@onready var side2 = $Sides/Side2
@onready var side3 = $Sides/Side3
@onready var side4 = $Sides/Side4
@onready var side5 = $Sides/Side5
@onready var side6 = $Sides/Side6
@onready var summon = $Summon
#endregion

#region builtin functions
func _ready() -> void:
	for side in $Sides.get_children():
		sides.append(side)

func _physics_process(delta: float) -> void:
	if not moving and rollable:
		static_time += delta
		if static_time > STATIC_TIME_THRESHOLD:
			dice_stopped.emit()
	else:
		static_time = 0.0
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
	var force = ROLL_FORCE_SCALER * Vector3(velocity.x, 0, velocity.y)
	var torque = get_random_torque()
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
	tween_rotate(Basis.from_euler(DIM_ROTATIONS[index]), 1)
	await tween.finished
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	dim_setup_finished.emit()

func unfold(_net):
	var tween = create_tween()
	var pivots = set_unfold_x()
	for pivot in pivots:
		pivot.unfold(tween)
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

func get_random_torque():
	var x_value = randf_range(-ROLL_TORQUE_LIMIT, ROLL_TORQUE_LIMIT)
	var y_value = randf_range(-ROLL_TORQUE_LIMIT, ROLL_TORQUE_LIMIT)
	var z_value = randf_range(-ROLL_TORQUE_LIMIT, ROLL_TORQUE_LIMIT)
	return Vector3(x_value, y_value, z_value)

func tween_rotate(_basis_to, time):
	basis_to = _basis_to
	quaternion_from = transform.basis.get_rotation_quaternion()
	var tween = create_tween()
	tween.tween_method(apply_quat_rotation, 0.0, 1.0, time)
	await tween.finished
	dice_rotation_finished.emit()

func apply_quat_rotation(t: float) -> void:
	var q = quaternion_from.slerp(basis_to, t)
	basis = Basis(q)

func set_unfold_x():
	side5.repartent(side6.pivot_down)
	side3.reparent(side6.pivot_right)
	side4.reparent(side6.pivot_left)
	side2.reparent(side6.pivot_up)
	side1.reparent(side5.pivot_up)
	return [side6.pivot_down, side6.pivot_right, side6.pivot_left, side6.pivot_up, side5.pivot_up]
#endregion
