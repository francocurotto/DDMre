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
    if dice_gui != selected_dice_gui:
        selected_dice_gui = dice_gui
        dice_selector.scale = selected_dice_gui.size / dice_selector.get_rect().size
        dice_selector.global_position = selected_dice_gui.global_position
        dice_selector.visible = true
