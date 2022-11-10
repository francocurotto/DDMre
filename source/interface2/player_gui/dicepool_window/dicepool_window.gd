extends VBoxContainer

# onready variables
onready var dicepool_column = $DicepoolPanel/DicepoolVBox/DicepoolColumn
onready var roll_gui = $RollPanel/RollVBox/RollGUI

# signals
signal info_button_pressed(card)

func _ready():
    # signal connections
    dicepool_column.connect("roll_triplet_increased", self, "on_roll_triplet_increased")
    dicepool_column.connect("roll_triplet_decreased", self, "on_roll_triplet_decreased")
    dicepool_column.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dicepool(dicepool):
    dicepool_column.set_dicepool(dicepool)

# signals callbacks
func on_roll_triplet_increased(idx, dice):
    roll_gui.add_to_roll_triplet(idx, dice)

func on_roll_triplet_decreased(idx):
    roll_gui.remove_from_triplet(idx)

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)
