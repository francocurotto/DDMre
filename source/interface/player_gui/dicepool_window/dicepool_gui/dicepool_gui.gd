extends PanelContainer

# variables
var dicepool
var dice_guis
var selected_dice_gui

# onready variables
@onready var grid =  $"5-3Ratio/Grid"
@onready var dice_selector = $"5-3Ratio/DiceSelector"

func _ready():
    # define dice guis
    dice_guis = grid.get_children()
    # connections
    for dice_gui in dice_guis:
        dice_gui.dice_entered.connect(on_dice_entered)

# public functions
func initialize(_dicepool):
    dicepool = _dicepool
    for i in len(dicepool):
        dice_guis[i].initialize(dicepool[i])
        
# signals callbacks
func on_dice_entered(dice_gui):
    # case first selection
    if selected_dice_gui == null:
        dice_selector.global_position = dice_gui.global_position
        dice_selector.scale_to_size(dice_gui.size)
        dice_selector.show()
    # case new selection
    if dice_gui != selected_dice_gui:
        selected_dice_gui = dice_gui
        dice_selector.target = selected_dice_gui.global_position
        
            
