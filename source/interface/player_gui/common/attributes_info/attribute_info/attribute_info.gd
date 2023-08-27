@tool
extends MarginContainer

# export variables
@export_range(0, 60, 10) var value = 30 :
    set(_value):
        value = _value
        if has_node("%ValueLabel"):
            %ValueLabel.text = "%2d" % value

@export_enum("ATTACK", "DEFENSE", "HEALTH") var attribute : String = "ATTACK" :
    set(_attribute):
        attribute = _attribute
        if has_node("%AttributeIcon"):
            var texture = load("res://art/icons/ATTR_%s.svg"%attribute)
            %AttributeIcon.texture = texture

# signals callbacks
func _on_resized():
    var icon_size = %AttributeIcon.size
    %ValueLabel.add_theme_font_size_override("font_size", icon_size.y-5)
