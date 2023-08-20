extends PanelContainer

# variables
var selected_dice_gui

# onready variables
@onready var grid =  $"5-3Ratio/Grid"
@onready var dice_selector = $"5-3Ratio/DiceSelector"

func _ready():
    # connections
    for dice_gui in grid.get_children():
        dice_gui.dice_entered.connect(on_dice_entered)

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
        
            
