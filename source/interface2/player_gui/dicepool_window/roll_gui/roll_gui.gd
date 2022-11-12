extends HBoxContainer

# onready variables
onready var roll_triplet = $RollTriplet

# public functions
func update_roll_triplet(idicepool):
    roll_triplet.update_dice(idicepool)
