extends VBoxContainer

# onready variables
onready var dicepool_column = $DicepoolPanel/DicepoolVBox/DicepoolColumn
onready var roll_gui = $RollPanel/RollVBox/RollGUI
#onready var dice_triplet = $RollPanel/RollVBox/RollGUI/DiceTriplet

# signals callbacks
func on_state_update_roll():
    roll_gui.reset() # must be before "on_dice_roll_button_toggled" line
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

func on_state_update_reply():
    dicepool_column.disable_roll()
