@tool
extends MarginContainer

# exports
@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") 
var type : String = "DRAGON" :
    set(_type):
        type = _type
        $DiceIcon.modulate = COLORS[type]

@export_range(1, 4) var level = 3 :
    set(_level):
        level = _level
        $Level.text = str(level)

# constants
const COLORS = {
    "DRAGON"      : Color(1.0,0.3,0.3),
    "SPELLCASTER" : Color(0.8,0.8,0.8),
    "UNDEAD"      : Color(1.0,1.0,0.3),
    "BEAST"       : Color(0.3,1.0,0.3),
    "WARRIOR"     : Color(0.3,0.3,1.0),
    "ITEM"        : Color(0.3,0.3,0.3)}

# signals
signal dice_entered(dice_gui)

# signals callbacks
func _on_resized():
    var min_size = min(size.y, size.x)
    $Level.add_theme_font_size_override("font_size", min_size/4)
    $Level.add_theme_constant_override("outline_size", min_size/8)

func _input(event):
    # event type bools
    var event_touch_pressed = event is InputEventScreenTouch and event.pressed
    var event_drag = event is InputEventScreenDrag
    # check event type
    if event_touch_pressed or event_drag:
        # check event inside dice
        if get_rect().has_point(event.position):
            dice_entered.emit(self)
