@tool
extends VBoxContainer

# export variables
@export var font_size : int = 60 :
    set(_font_size):
        font_size = _font_size
        $AbilityInfo1.font_size = font_size
        $AbilityInfo2.font_size = font_size

# public functions
func setup(abilities):
    # reset abilities
    $AbilityInfo1.visible = false
    $AbilityInfo2.visible = false
    # set new abilities
    for i in len(abilities):
        var ability_info = get_child(i)
        var ability_entry = Globals.ABIDICT[abilities[i].name]
        ability_info.ability_name = ability_entry["NAME"]
        ability_info.visible = true
        
