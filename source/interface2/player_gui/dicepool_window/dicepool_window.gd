extends VBoxContainer

# onready variables
onready var dicepool_column = $DicepoolPanel/DicepoolVBox/DicepoolColumn
onready var roll_gui = $RollPanel/RollVBox/RollGUI

# signals
signal info_button_pressed(card)

func _ready():
    # signal connections
    dicepool_column.connect("roll_triplet_changed", self, "on_roll_triplet_changed")
    dicepool_column.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dicepool(dicepool):
    dicepool_column.set_dicepool(dicepool)

# signals callbacks
func on_roll_triplet_changed(idicepool):
    roll_gui.update_roll_triplet(idicepool)

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)
