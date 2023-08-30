@tool
extends MarginContainer

# export variables
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
            var texture = load("res://art/icons/CREST_%s.svg" % crest)
            $CrestIcon.texture = texture

# constants
const COLORS = {
    "DRAGON"      : Color(1.0,0.3,0.3),
    "SPELLCASTER" : Color(0.8,0.8,0.8),
    "UNDEAD"      : Color(1.0,1.0,0.3),
    "BEAST"       : Color(0.3,1.0,0.3),
    "WARRIOR"     : Color(0.3,0.3,1.0),
    "ITEM"        : Color(0.3,0.3,0.3)}
