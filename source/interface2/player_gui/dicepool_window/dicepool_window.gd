extends VBoxContainer

# onready variables
onready var dicepool_column = $DicepoolPanel/DicepoolVBox/DicepoolColumn
onready var roll_gui = $RollPanel/RollVBox/RollGUI
onready var dice_triplet = $RollPanel/RollVBox/RollGUI/DiceTriplet

# signals
signal roll_button_pressed(indeces)

func _ready():
    # signal connections
    dicepool_column.connect("dice_triplet_changed", self, "on_dice_triplet_changed")
    roll_gui.connect("roll_button_pressed", self, "on_roll_button_pressed")

# signals callbacks
func on_state_update_roll():
    dice_triplet.reset()
    dicepool_column.enable_roll_undimensioned()
    dicepool_column.on_dice_roll_button_toggled()

func on_state_update_dungeon():
    dicepool_column.disable_roll()
    roll_gui.disable_roll()

func on_state_update_dimension(dim_candidates):
    dicepool_column.disable_roll()
    dicepool_column.switch_to_dim(dim_candidates)
    roll_gui.disable_roll()

func on_dice_triplet_changed(idicepool):
    roll_gui.update_dice_triplet(idicepool)

func on_roll_button_pressed():
    var indeces = dicepool_column.get_roll_indeces()
    emit_signal("roll_button_pressed", indeces)
