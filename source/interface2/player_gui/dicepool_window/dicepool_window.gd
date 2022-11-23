extends VBoxContainer

# onready variables
onready var dicepool_column = $DicepoolPanel/DicepoolVBox/DicepoolColumn
onready var roll_gui = $RollPanel/RollVBox/RollGUI

# signals
signal roll_button_pressed(indeces)

func _ready():
    # signal connections
    dicepool_column.connect("roll_triplet_changed", self, "on_roll_triplet_changed")
    roll_gui.connect("roll_button_pressed", self, "on_roll_button_pressed")

# signals callbacks
func on_roll_triplet_changed(idicepool):
    roll_gui.update_roll_triplet(idicepool)

func on_roll_button_pressed():
    var indeces = dicepool_column.get_roll_indeces()
    emit_signal("roll_button_pressed", indeces)

func on_state_update_dungeon():
    print("ASDF")
    dicepool_column.disable_roll()
    roll_gui.disable_roll()

func on_state_update_dimension(dim_candidates):
    dicepool_column.disable_roll()
    dicepool_column.switch_to_dim(dim_candidates)
    roll_gui.disable_roll()
