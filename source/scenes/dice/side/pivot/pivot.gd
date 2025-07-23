extends Node3D

#region constants
const UNFOLD_TIME = 0.5
const AXES = {
	"UP" : "rotation:x",
	"LEFT" : "rotation:y",
	"RIGHT" : "rotation:y",
	"DOWN" : "rotation:x"
}
const ANGLES = {
	"UP" : PI/2,
	"LEFT" : PI/2,
	"RIGHT" : -PI/2,
	"DOWN" : -PI/2
}
#endregion

#region export variables
@export_enum("UP", "LEFT", "RIGHT", "DOWN") var location : String = "UP"
#endregion

#region public variables
var sequence = 1 # sequence number for parallel tween during unfolding
#endregion

#region public functions
func unfold(tween, parallel):
	tween.set_parallel(parallel)
	tween.tween_property(self, AXES[location], ANGLES[location], UNFOLD_TIME)
#endregion
