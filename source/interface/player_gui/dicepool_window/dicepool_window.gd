extends MarginContainer

# public functions
func setup(dicepool):
    %DicepoolGUI.setup(dicepool)

# signals callbacks
func _on_dicepool_gui_dice_gui_selected(dice):
    %DiceInfo.setup(dice)
