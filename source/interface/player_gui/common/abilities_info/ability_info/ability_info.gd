@tool
extends MarginContainer

# export variables
@export var ability_name : String = "FLY" :
    set(_ability_name):
        ability_name = _ability_name
        # set ability name
        %AbilityName.text = ability_name
        # create file suffix
        var file_suffix = "" 
        if ability_name in COMMON_ABILITIES:
            file_suffix = "_" + ability_name
         # set ability icon
        var texture = load("res://art/icons/ABILITY%s.svg" % file_suffix)
        if ability_name.is_empty():
            %AbilityIcon.texture = null
            $AbilityButton.disabled = true
        else:
            %AbilityIcon.texture = texture
            $AbilityButton.disabled = false
        
# constants
const COMMON_ABILITIES = ["FLY", "TUNNEL", "ARCHER", "NEUTRAL"]

# signals callbacks
func _on_resized():
    %AbilityName.add_theme_font_size_override("font_size", size.y-5)

func _on_ability_button_pressed():
    print(ability_name + " ability pressed")
