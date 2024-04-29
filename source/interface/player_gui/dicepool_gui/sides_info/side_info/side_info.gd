@tool
extends AspectRatioContainer

#region constants
const COLORS = {
    "DRAGON"      : Color(1.0,0.3,0.3),
    "SPELLCASTER" : Color(0.8,0.8,0.8),
    "UNDEAD"      : Color(1.0,1.0,0.3),
    "BEAST"       : Color(0.3,1.0,0.3),
    "WARRIOR"     : Color(0.3,0.3,1.0),
    "ITEM"        : Color(0.3,0.3,0.3)}
#endregion

#region export variables
@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") 
var type : String = "DRAGON" :
    set(_type):
        type = _type
        if has_node("SideIcon"):
            $SideIcon.self_modulate = COLORS[type]

@export_enum("SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP") 
var crest : String = "SUMMON" :
    set(_crest):
        crest = _crest
        if has_node("CrestIcon"):
            set_crest_and_mult()

@export_range(1, 9) var mult = 1 :
    set(_mult):
        mult = _mult
        if has_node("%Mult"):
            set_crest_and_mult()
            _on_resized()
#endregion

#region public functions
func setup(_type, side):
    type = _type
    crest = side.crest.TYPE
    mult = side.mult
#endregion

#region signals callbacks
func _on_resized():
    var side_size = min(size.y, size.x)
    $MultContainer.add_theme_constant_override("margin_top", side_size/15)
    $MultContainer.add_theme_constant_override("margin_bottom", side_size/15)
    $MultContainer.add_theme_constant_override("margin_left", side_size/15)
    $MultContainer.add_theme_constant_override("margin_right", side_size/15)
    %Mult.add_theme_font_size_override("font_size", side_size/2)
    %Mult.add_theme_constant_override("outline_size", side_size/7)
#endregion

#region private functions
func set_crest_and_mult():
    # set crest icon
    var texture = load("res://assets/icons/CREST_%s.svg" % crest)
    $CrestIcon.texture = texture
    %Mult.text = str(mult)
    # set mult
    if crest == "SUMMON":
        %Mult.size_flags_horizontal = SIZE_SHRINK_CENTER
        %Mult.size_flags_vertical   = SIZE_SHRINK_CENTER
        %Mult.visible = true
    else:
        %Mult.size_flags_horizontal = SIZE_SHRINK_END
        %Mult.size_flags_vertical   = SIZE_SHRINK_END
        %Mult.visible = mult != 1
#endregion
