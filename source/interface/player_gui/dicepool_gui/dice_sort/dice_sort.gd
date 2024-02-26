extends MarginContainer

# signals
signal sort_button_pressed

# variables
var dice_sort_button_group = ButtonGroup.new()

var sort_level : 
    get: 
        return %SortSummon.button_pressed

var sort_crest :
    get:
        var pressed_button = %SortMovement.button_group.get_pressed_button()
        if pressed_button != null:
            return pressed_button.crest
        return null

func _ready():
    dice_sort_button_group.allow_unpress = true
    %SortSummon.pressed.connect(func(): sort_button_pressed.emit())
    for button in %CrestsHBox.get_children():
        button.pressed.connect(func(): sort_button_pressed.emit())
        button.button_group = dice_sort_button_group
        