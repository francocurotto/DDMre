extends VBoxContainer

# onready variables
onready var dicepool_column = $DicepoolPanel/DicepoolVBox/DicepoolColumn
onready var roll_gui = $RollPanel/RollVBox/RollGUI

# signals
signal info_button_pressed(card)
signal roll_input(indeces)

func _ready():
    # signal connections
    dicepool_column.connect("roll_triplet_changed", self, "on_roll_triplet_changed")
    dicepool_column.connect("info_button_pressed", self, "on_info_button_pressed")
    roll_gui.connect("roll_input", self, "on_roll_input")

# setget functions
func set_dicepool(dicepool):
    dicepool_column.set_dicepool(dicepool)

func set_roll(sides):
    roll_gui.set_roll(sides)

# signals callbacks
func on_roll_triplet_changed(idicepool):
    roll_gui.update_roll_triplet(idicepool)

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

func on_roll_input():
    var indeces = dicepool_column.get_roll_indeces()
    emit_signal("roll_input", indeces)

func on_state_update_dungeon():
    dicepool_column.disable_roll()
    roll_gui.disable_roll()

func on_state_update_dimension(dim_candidates):
    dicepool_column.disable_roll()
    dicepool_column.switch_to_dim(dim_candidates)
    roll_gui.disable_roll()
