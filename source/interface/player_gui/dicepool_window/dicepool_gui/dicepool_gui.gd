extends PanelContainer

# variables
var selected_dice_gui

# onready variables
@onready var grid =  $"5-3Ratio/Grid"
@onready var dice_gui1 = $"5-3Ratio/Grid/DiceGUI1"
@onready var selector = $"5-3Ratio/Selector"

func _ready():
    # set selector size
    selector.scale = dice_gui1.size / selector.get_rect().size
    # connections
    for dice_gui in grid.get_children():
        dice_gui.dice_entered.connect(on_dice_entered)

# signals callbacks
func on_dice_entered(dice_gui):
    if dice_gui != selected_dice_gui:
        selected_dice_gui = dice_gui
        selector.position = selected_dice_gui.position
        selector.visible = true
