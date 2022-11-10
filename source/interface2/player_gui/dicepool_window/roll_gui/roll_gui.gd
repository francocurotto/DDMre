extends HBoxContainer

# onready variables
onready var roll_triplet = $RollTriplet

# public functions
func add_to_roll_triplet(idx, dice):
    roll_triplet.add_dice(idx, dice)

func remove_from_roll_triplet(idx):
    roll_triplet.remove_dice(idx)
