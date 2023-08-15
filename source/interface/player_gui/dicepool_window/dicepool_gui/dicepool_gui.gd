extends PanelContainer

# variables
var selected_dice_gui

# onready variables
@onready var grid =  $"5-3Ratio/Grid"
@onready var selector = $"5-3Ratio/Grid/DiceGUI1/Selector"

func _ready():
    # connections
    for dice_gui in grid.get_children():
        dice_gui.dice_entered.connect(on_dice_entered)

# signals callbacks
func on_dice_entered(dice_gui):
    print(selector.position)
    if dice_gui != selected_dice_gui:
        selected_dice_gui = dice_gui
        print(selector.position)
        selector.position = selected_dice_gui.position
        print(selector.position)
        #selector.get_parent().remove_child(selector)
        #selected_dice_gui.add_child(selector)
        selector.visible = true
        print(selector.position)
