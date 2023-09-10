@tool
extends Button

@export_enum("SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP") 
var crest : String = "SUMMON" :
    set(_crest):
        crest = _crest
        icon = load("res://assets/icons/CREST_%s.svg" % crest)
