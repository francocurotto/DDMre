@tool
extends RigidBody3D
class_name Dice

#region constants
const STATIC_LINEAR_VELOCITY_THRESHOLD = 0.1
const STATIC_ANGULAR_VELOCITY_THRESHOLD = 0.2
const STATIC_TIME_THRESHOLD = 0.5
const ROLLED_SIDE_THRESHOLD = 0.99
const ROLL_FORCE_SCALER = 0.01
const ROLL_TORQUE_LIMIT = 5
const Item = preload("res://scenes/dungobj/summon/item.tscn")
const MONSTER_DICT = {
	"DRAGON" :  preload("res://scenes/dungobj/summon/dragon.tscn"),
	"SPELLCASTER" : preload("res://scenes/dungobj/summon/spellcaster.tscn"),
	"UNDEAD" : preload("res://scenes/dungobj/summon/undead.tscn"),
	"BEAST" : preload("res://scenes/dungobj/summon/beast.tscn"),
	"WARRIOR" : preload("res://scenes/dungobj/summon/warrior.tscn")
}
#endregion

#region signals
signal dice_stopped
signal dim_setup_finished
signal dimdice_movement_started
signal dimdice_movement_finished
signal dimension_started
signal dimension_finished
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

@export var dimensioned : bool = false :
	set(_dimensioned):
		dimensioned = _dimensioned
		for side in $Sides.get_children():
			side.dimensioned = dimensioned
#endregion

#region public variables
var roll_flag = false
var sides = []
var summon
var player : int :
	set(_player):
		player = _player
		for side in sides:
			side.player = player
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
var index # number representing the dice position in the dicepool
var dice_dict # copy of dice data needed when duplicating
var static_time = 0.0
var tween_quat0 # origin quaternion for rotation tween
var tween_quat1 = quaternion # end quaternion for rotation tween
var pivots = [] # array of pivots for dimensioning
var pivot_sequence = 1 # current pivot sequence to define parallel unfolding
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
#endregion

#region builtin functions
func _ready() -> void:
	for side in $Sides.get_children():
		sides.append(side)

func _physics_process(delta: float) -> void:
	if not moving and roll_flag:
		static_time += delta
		if static_time > STATIC_TIME_THRESHOLD:
			roll_flag = false
			dice_stopped.emit()
	else:
		static_time = 0.0
#endregion

#region public functions
func set_dice(_index, _dice_dict, _player):
	index = _index
	player = _player
	dice_dict = _dice_dict
	var level = int(dice_dict["LEVEL"])
	var type = dice_dict["TYPE"]
	# set sides
	var side_strings = split_sides_string(dice_dict["CRESTS"])
	for i in 6:
		$Sides.get_child(i).set_side(type, level, side_strings[i])
	# set summon
	if type == "ITEM":
		summon = Item.instantiate()
	else:
		summon = MONSTER_DICT[type].instantiate()
	summon.set_summon(dice_dict, player)

func clone():
	var copy = duplicate()
	copy.set_dice(index, dice_dict, player)
	return copy

func roll(velocity):
	roll_flag = true
	var force = ROLL_FORCE_SCALER * Vector3(velocity.x, 0, velocity.y)
	var torque = get_random_torque()
	gravity_scale = 1 # activate gravity
	apply_central_impulse(force)
	apply_torque_impulse(torque)

func tween_remove(tween):
	# Vector3 is not ZERO cause it produces det==0 error
	tween.tween_property(self, "scale", Vector3(0.01,0.01,0.01), 1)
	await tween.finished
	queue_free()

func setup_dim_select(tween, new_position):
	gravity_scale = 0 # disable gravity
	tween.tween_property(self, "position", new_position, 1)
	var roll_index = rolled_side.get_index() 
	tween_rotate(Basis.from_euler(DIM_ROTATIONS[roll_index]), 1)
	await tween.finished
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	dim_setup_finished.emit()

func unfold(net):
	dimension_started.emit()
	$Summon.visible = true
	var tween = create_tween()
	tween.tween_property(self, "position:y", Globals.DIMENSION_HEIGHT, 0.1)
	tween.set_trans(Tween.TRANS_SINE)
	if net.orientation == 1:
		call("set_unfold_%s" % net.type)
	else:
		call("set_unfold_%s_flipped" % net.type)
	var base_side = $Sides.get_child(0)
	base_side.reparent_summon(summon)
	for pivot in pivots:
		pivot.unfold(tween, pivot.sequence==pivot_sequence)
		pivot_sequence = pivot.sequence
	tween.set_parallel(false)
	summon.tween_dimension(tween)
	await tween.finished
	dimension_finished.emit()
	for side in sides:
		side.reparent_path_tile()
	queue_free()
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

func tween_rotate(_tween_quat1, time):
	dimdice_movement_started.emit()
	tween_quat1 = _tween_quat1
	tween_quat0 = transform.basis.get_rotation_quaternion()
	var tween = create_tween()
	tween.tween_method(apply_quat_rotation, 0.0, 1.0, time)
	await tween.finished
	dimdice_movement_finished.emit()

func apply_quat_rotation(t: float) -> void:
	var q = tween_quat0.slerp(tween_quat1, t)
	basis = Basis(q)

func set_unfold_X():
	set_pivot(side1, side5.pivot_up, 1)
	set_pivot(side2, side6.pivot_up, 2)
	set_pivot(side3, side6.pivot_right, 2)
	set_pivot(side4, side6.pivot_left, 2)
	set_pivot(side5, side6.pivot_down, 2)

func set_unfold_T():
	set_pivot(side3, side2.pivot_right, 1)
	set_pivot(side4, side2.pivot_left, 1)
	set_pivot(side1, side5.pivot_up, 1)
	set_pivot(side2, side6.pivot_up, 2)
	set_pivot(side5, side6.pivot_down, 2)

func set_unfold_Y():
	set_pivot(side3, side2.pivot_right, 1)
	set_pivot(side1, side5.pivot_up, 1)
	set_pivot(side2, side6.pivot_up, 2)
	set_pivot(side5, side6.pivot_down, 2)
	set_pivot(side4, side6.pivot_left, 2)

func set_unfold_Z():
	set_pivot(side4, side1.pivot_right, 1)
	set_pivot(side3, side2.pivot_right, 2)
	set_pivot(side1, side5.pivot_up, 2)
	set_pivot(side2, side6.pivot_up, 3)
	set_pivot(side5, side6.pivot_down, 3)

func set_unfold_V():
	set_pivot(side4, side5.pivot_right, 1)
	set_pivot(side1, side5.pivot_up, 1)
	set_pivot(side3, side2.pivot_right, 1)
	set_pivot(side2, side6.pivot_up, 2)
	set_pivot(side5, side6.pivot_down, 2)

func set_unfold_N():
	set_pivot(side1, side5.pivot_up, 1)
	set_pivot(side4, side5.pivot_right, 1)
	set_pivot(side2, side6.pivot_up, 2)
	set_pivot(side3, side6.pivot_right, 2)
	set_pivot(side5, side6.pivot_down, 2)

func set_unfold_M():
	set_pivot(side1, side4.pivot_up, 1)
	set_pivot(side3, side2.pivot_right, 2)
	set_pivot(side4, side5.pivot_right, 2)
	set_pivot(side2, side6.pivot_up, 3)
	set_pivot(side5, side6.pivot_down, 3)

func set_unfold_E():
	set_pivot(side1, side4.pivot_up, 1)
	set_pivot(side2, side3.pivot_left, 2)
	set_pivot(side4, side5.pivot_right, 2)
	set_pivot(side3, side6.pivot_right, 3)
	set_pivot(side5, side6.pivot_down, 3)

func set_unfold_P():
	set_pivot(side1, side5.pivot_up, 1)
	set_pivot(side2, side3.pivot_left, 1)
	set_pivot(side3, side6.pivot_right, 2)
	set_pivot(side4, side6.pivot_left, 2)
	set_pivot(side5, side6.pivot_down, 2)

func set_unfold_R():
	set_pivot(side1, side5.pivot_up, 1)
	set_pivot(side2, side3.pivot_left, 1)
	set_pivot(side4, side5.pivot_right, 1)
	set_pivot(side3, side6.pivot_right, 2)
	set_pivot(side5, side6.pivot_down, 2)

func set_unfold_L():
	set_pivot(side3, side5.pivot_left, 1)
	set_pivot(side5, side4.pivot_left, 2)
	set_pivot(side1, side2.pivot_up, 2)
	set_pivot(side2, side6.pivot_up, 3)
	set_pivot(side4, side6.pivot_left, 3)

func set_unfold_X_flipped():
	set_pivot(side6, side5.pivot_down, 1)
	set_pivot(side2, side1.pivot_up, 2)
	set_pivot(side3, side1.pivot_left, 2)
	set_pivot(side4, side1.pivot_right, 2)
	set_pivot(side5, side1.pivot_down, 2)

func set_unfold_T_flipped():
	set_pivot(side3, side2.pivot_right, 1)
	set_pivot(side4, side2.pivot_left, 1)
	set_pivot(side6, side5.pivot_down, 1)
	set_pivot(side2, side1.pivot_up, 2)
	set_pivot(side5, side1.pivot_down, 2)

func set_unfold_Y_flipped():
	set_pivot(side3, side2.pivot_right, 1)
	set_pivot(side6, side5.pivot_down, 1)
	set_pivot(side2, side1.pivot_up, 2)
	set_pivot(side5, side1.pivot_down, 2)
	set_pivot(side4, side1.pivot_right, 2)

func set_unfold_Z_flipped():
	set_pivot(side4, side6.pivot_left, 1)
	set_pivot(side3, side2.pivot_right, 2)
	set_pivot(side6, side5.pivot_down, 2)
	set_pivot(side2, side1.pivot_up, 3)
	set_pivot(side5, side1.pivot_down, 3)

func set_unfold_V_flipped():
	set_pivot(side4, side5.pivot_right, 1)
	set_pivot(side6, side5.pivot_down, 1)
	set_pivot(side3, side2.pivot_right, 1)
	set_pivot(side2, side1.pivot_up, 2)
	set_pivot(side5, side1.pivot_down, 2)

func set_unfold_N_flipped():
	set_pivot(side4, side5.pivot_right, 1)
	set_pivot(side6, side5.pivot_down, 1)
	set_pivot(side3, side1.pivot_left, 2)
	set_pivot(side2, side1.pivot_up, 2)
	set_pivot(side5, side1.pivot_down, 2)

func set_unfold_M_flipped():
	set_pivot(side6, side4.pivot_down, 1)
	set_pivot(side4, side5.pivot_right, 2)
	set_pivot(side3, side2.pivot_right, 2)
	set_pivot(side2, side1.pivot_up, 3)
	set_pivot(side5, side1.pivot_down, 3)

func set_unfold_E_flipped():
	set_pivot(side6, side4.pivot_down, 1)
	set_pivot(side4, side5.pivot_right, 2)
	set_pivot(side2, side3.pivot_left, 2)
	set_pivot(side3, side1.pivot_left, 3)
	set_pivot(side5, side1.pivot_down, 3)

func set_unfold_P_flipped():
	set_pivot(side6, side5.pivot_down, 1)
	set_pivot(side2, side3.pivot_left, 1)
	set_pivot(side4, side1.pivot_right, 2)
	set_pivot(side3, side1.pivot_left, 2)
	set_pivot(side5, side1.pivot_down, 2)

func set_unfold_R_flipped():
	set_pivot(side6, side5.pivot_down, 1)
	set_pivot(side4, side5.pivot_right, 1)
	set_pivot(side2, side3.pivot_left, 1)
	set_pivot(side3, side1.pivot_left, 2)
	set_pivot(side5, side1.pivot_down, 2)

func set_unfold_L_flipped():
	set_pivot(side3, side5.pivot_left, 1)
	set_pivot(side5, side4.pivot_left, 2)
	set_pivot(side6, side2.pivot_down, 2)
	set_pivot(side4, side1.pivot_right, 3)
	set_pivot(side2, side1.pivot_up, 3)

func set_pivot(side, pivot, sequence):
	side.reparent(pivot)
	pivot.sequence = sequence
	pivots.append(pivot)
#endregion
