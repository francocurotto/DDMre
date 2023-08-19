extends PanelContainer

# variables
var selected_dice_gui

# onready variables
@onready var grid =  $"5-3Ratio/Grid"
@onready var selector = $"5-3Ratio/Selector"

func _ready():
    # connections
    for dice_gui in grid.get_children():
        dice_gui.dice_entered.connect(on_dice_entered)

# signals callbacks
func on_dice_entered(dice_gui):
    if dice_gui != selected_dice_gui:
        selected_dice_gui = dice_gui
        selector.scale = selected_dice_gui.size / selector.get_rect().size
        selector.global_position = selected_dice_gui.global_position
        selector.visible = true
