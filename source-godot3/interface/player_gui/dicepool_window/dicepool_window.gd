extends VBoxContainer

# onready variables
onready var dicepool_gui = $DicepoolGUI
onready var roll_gui = $RollGUI

# signals callbacks
func on_state_update_roll():
    roll_gui.reset() # must be before "on_dice_gui_roll_button_toggled" line
    dicepool_gui.enable_roll_undimensioned()
    dicepool_gui.disable_dim_dimensioned()
    dicepool_gui.on_dice_gui_roll_button_toggled() # save last dice roll

func on_state_update_dungeon():
    dicepool_gui.disable_roll()
    roll_gui.disable_roll()

func on_state_update_dimension(dim_candidates):
    dicepool_gui.disable_roll()
    dicepool_gui.enable_dim_candidates(dim_candidates)
    roll_gui.disable_roll()
    roll_gui.switch_to_skip_button()

func on_state_update_dim_ability():
    on_state_update_dungeon()

func on_state_update_reply():
    dicepool_gui.disable_roll()
