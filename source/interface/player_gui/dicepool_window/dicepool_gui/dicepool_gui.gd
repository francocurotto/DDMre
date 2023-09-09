extends PanelContainer

# variables
var dicepool
var dice_guis
var selected_dice_gui

func _ready():
    # define dice guis
    dice_guis = %Grid.get_children()
    # connections
    for dice_gui in dice_guis:
        dice_gui.dice_entered.connect(on_dice_entered)

# public functions
func setup(_dicepool):
    dicepool = _dicepool
    for i in len(dicepool):
        dice_guis[i].setup(dicepool[i])
        
# signals callbacks
func on_dice_entered(dice_gui):
    # case first selection
    if selected_dice_gui == null:
        %DiceSelector.global_position = dice_gui.global_position
        %DiceSelector.scale_to_size(dice_gui.size)
        %DiceSelector.show()
    # update selected dice gui
    if selected_dice_gui != dice_gui:
        selected_dice_gui = dice_gui
        %DiceSelector.target = selected_dice_gui.global_position
        %DiceInfo.setup(selected_dice_gui.dice)    
