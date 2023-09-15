@tool
extends MarginContainer

# export variables
@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") 
var type : String = "DRAGON" :
    set(_type):
        type = _type
        if has_node("DiceIcon"):
            $DiceIcon.self_modulate = COLORS[type]

@export_range(1, 4) var level = 1 :
    set(_level):
        level = _level
        if has_node("LevelLabel"):
            $LevelLabel.text = str(level)

# constants
const COLORS = {
    "DRAGON"      : Color(1.0,0.3,0.3),
    "SPELLCASTER" : Color(0.8,0.8,0.8),
    "UNDEAD"      : Color(1.0,1.0,0.3),
    "BEAST"       : Color(0.3,1.0,0.3),
    "WARRIOR"     : Color(0.3,0.3,1.0),
    "ITEM"        : Color(0.3,0.3,0.3)}

# variables
var dice

# signals
signal dice_entered(dice_gui)
signal changed_position(dice_gui)

# public functions
func setup(_dice):
    dice = _dice
    type = dice.card.type
    level = dice.level

# signals callbacks
func _on_resized():
    var min_size = min(size.y, size.x)
    $LevelLabel.add_theme_font_size_override("font_size", min_size/4)
    $LevelLabel.add_theme_constant_override("outline_size", min_size/8)

func _on_item_rect_changed():
    changed_position.emit(self)

func _input(event):
    # check event type
    if (event is InputEventScreenTouch and event.pressed or
        event is InputEventScreenDrag):
        # check event inside dice
        var rect = Rect2(global_position, size)
        if rect.has_point(event.position):
            dice_entered.emit(self)
