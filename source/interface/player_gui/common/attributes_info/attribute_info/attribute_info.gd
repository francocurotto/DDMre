@tool
extends PanelContainer

# export variables
@export_range(0, 60, 10) var value = 30 :
    set(_value):
        value = _value
        value_label.text = "%2d" % value

@export_enum("ATTACK", "DEFENSE", "HEALTH") var attribute : String = "ATTACK" :
    set(_attribute):
        attribute = _attribute
        attribute_icon.texture = load("res://art/icons/ATTR_%s.svg"%attribute)

# variables
var attribute_icon
var value_label

func _enter_tree():
    attribute_icon = $HBox/AttributeIcon
    value_label = $HBox/ValueLabel

# signals callbacks
func _on_resized():
    var icon_size = attribute_icon.size
    value_label.add_theme_font_size_override("font_size", icon_size.y-5)
