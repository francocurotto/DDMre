@tool
extends PanelContainer

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
        var texture = load("res://assets/icons/ABILITY%s.svg" % file_suffix)
        if ability_name.is_empty():
            %AbilityIcon.texture = null
            $AbilityButton.disabled = true
        else:
            %AbilityIcon.texture = texture
            %AbilityButton.disabled = false
        
@export var font_size : int = 60 :
    set(_font_size):
        font_size = _font_size
        %AbilityName.add_theme_font_size_override("font_size", font_size)
        
# constants
const COMMON_ABILITIES = ["FLY", "TUNNEL", "ARCHER", "NEUTRAL"]    

func _on_ability_button_button_down():
    modulate = Color(1,1,1,0.5)

func _on_ability_button_button_up():
    print(ability_name + " ability pressed")
    modulate = Color(1,1,1,1)
