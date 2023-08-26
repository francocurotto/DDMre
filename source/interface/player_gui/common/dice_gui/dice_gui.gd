@tool
extends MarginContainer

# export variables
@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") 
var type : String = "DRAGON" :
    set(_type):
        type = _type
        dice_icon.modulate = COLORS[type]

@export_range(1, 4) var level = 3 :
    set(_level):
        level = _level
        level_label.text = str(level)

# variables
var dice_icon
var level_label
var dice

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

func _enter_tree():
    dice_icon = $DiceIcon
    level_label = $LevelLabel

# public vatriables
func setup(_dice):
    dice = _dice
    type = dice.card.type
    level = dice.level

# signals callbacks
func _on_resized():
    var min_size = min(size.y, size.x)
    level_label.add_theme_font_size_override("font_size", min_size/4)
    level_label.add_theme_constant_override("outline_size", min_size/8)

func _input(event):
    # check event type
    if (event is InputEventScreenTouch and event.pressed or
        event is InputEventScreenDrag):
        # check event inside dice
        var rect = Rect2(global_position, size)
        if rect.has_point(event.position):
            dice_entered.emit(self)
