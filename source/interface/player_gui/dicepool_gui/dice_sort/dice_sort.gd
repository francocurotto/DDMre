extends MarginContainer

#region signals
signal sort_button_pressed
#endregion

#region variables
var dice_sort_button_group = ButtonGroup.new()
var sort_level : get = get_sort_level 
var sort_crest : get = get_sort_crest
#endregion

#region builtin functions
func _ready():
    dice_sort_button_group.allow_unpress = true
    %SortSummon.pressed.connect(func(): sort_button_pressed.emit())
    for button in %CrestsHBox.get_children():
        button.pressed.connect(func(): sort_button_pressed.emit())
        button.button_group = dice_sort_button_group
#endregion

#region private functions
func get_sort_level():
    return %SortSummon.button_pressed

func get_sort_crest():
    var pressed_button = %SortMovement.button_group.get_pressed_button()
    if pressed_button != null:
        return pressed_button.crest
    return null
#endregion
