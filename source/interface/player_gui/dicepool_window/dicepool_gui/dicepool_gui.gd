extends PanelContainer

# variables
var selected_dice_gui

# onready variables
@onready var grid =  $"5-3Ratio/Grid"

func _ready():
    # connections
    for dice_gui in grid.get_children():
        dice_gui.dice_entered.connect(on_dice_entered)

# signals callbacks
func on_dice_entered(dice_gui):
    if dice_gui != selected_dice_gui:
        selected_dice_gui = dice_gui
        print("dice entered " + str(dice_gui.get_index()))

