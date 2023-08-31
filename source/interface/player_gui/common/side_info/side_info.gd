@tool
extends AspectRatioContainer

# export variables
@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") 
var type : String = "DRAGON" :
    set(_type):
        type = _type
        if has_node("SideIcon"):
            $SideIcon.self_modulate = COLORS[type]

@export_enum("SUMMON2", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP") 
var crest : String = "SUMMON2" :
    set(_crest):
        crest = _crest
        if has_node("CrestIcon"):
            set_crest_and_mult()

@export_range(1, 9) var mult = 1 :
    set(_mult):
        mult = _mult
        if has_node("%Mult"):
            set_crest_and_mult()

# constants
const COLORS = {
    "DRAGON"      : Color(1.0,0.3,0.3),
    "SPELLCASTER" : Color(0.8,0.8,0.8),
    "UNDEAD"      : Color(1.0,1.0,0.3),
    "BEAST"       : Color(0.3,1.0,0.3),
    "WARRIOR"     : Color(0.3,0.3,1.0),
    "ITEM"        : Color(0.3,0.3,0.3)}

# signals callbacks
func _on_resized():
    var side_size = $SideIcon.size.y
    %Mult.add_theme_font_size_override("font_size", side_size/3)
    %Mult.add_theme_constant_override("outline_size", side_size/8)

# private functions
func set_crest_and_mult():
    # set crest icon
    var texture = load("res://art/icons/CREST_%s.svg" % crest)
    $CrestIcon.texture = texture
    %Mult.text = str(mult)
    # set mult
    if crest == "SUMMON2":
        %Mult.size_flags_horizontal = SIZE_SHRINK_CENTER
        %Mult.size_flags_vertical   = SIZE_SHRINK_CENTER
        %Mult.visible = true
    else:
        %Mult.size_flags_horizontal = SIZE_SHRINK_END
        %Mult.size_flags_vertical   = SIZE_SHRINK_END
        %Mult.visible = mult != 1
