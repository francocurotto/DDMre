extends VBoxContainer

# onready variables
onready var dicepool_column = $DicepoolPanel/DicepoolVBox/DicepoolColumn
onready var roll_gui = $RollPanel/RollVBox/RollGUI
onready var dice_triplet = $RollPanel/RollVBox/RollGUI/DiceTriplet

# signals
signal roll_button_pressed(indeces)
signal dice_dim_button_pressed(dicecol)
signal dice_dim_button_released

func _ready():
    # signal connections
    dicepool_column.connect("dice_triplet_changed", self, "on_dice_triplet_changed")
    dicepool_column.connect("dice_dim_button_pressed", self, "on_dice_dim_button_pressed")
    dicepool_column.connect("dice_dim_button_released", self, "on_dice_dim_button_released")
    roll_gui.connect("roll_button_pressed", self, "on_roll_button_pressed")

# signals callbacks
func on_state_update_roll():
    dice_triplet.reset() # must be before "on_dice_roll_button_toggled" line
    dicepool_column.enable_roll_undimensioned()
    dicepool_column.disable_dim_dimensioned()
    dicepool_column.on_dice_roll_button_toggled() # save last dice roll

func on_state_update_dungeon():
    dicepool_column.disable_roll()
    roll_gui.disable_roll()

func on_state_update_dimension(dim_candidates):
    dicepool_column.disable_roll()
    dicepool_column.enable_dim_candidates(dim_candidates)
    roll_gui.disable_roll()
    roll_gui.switch_to_skip_button()

func on_dice_triplet_changed(idicepool):
    roll_gui.update_dice_triplet(idicepool)

func on_roll_button_pressed():
    var indeces = dicepool_column.get_roll_indeces()
    emit_signal("roll_button_pressed", indeces)

func on_dice_dim_button_pressed(dicecol):
    roll_gui.on_dice_dim_button_pressed()
    emit_signal("dice_dim_button_pressed", dicecol)

func on_dice_dim_button_released():
    roll_gui.on_dice_dim_button_released()
    emit_signal("dice_dim_button_released")
