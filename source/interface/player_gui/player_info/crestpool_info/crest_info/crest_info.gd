@tool
extends HBoxContainer

# export variables
@export_enum("MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP") 
var crest_type : String = "MOVEMENT" :
    set(_crest_type):
        crest_type = _crest_type
        set_crest_info()

@export_range(0, 99) var crest_count = 0 :
    set(_crest_count):
        crest_count = _crest_count
        set_crest_info()

func set_crest_info():
    $CrestType.texture = load("res://assets/icons/CREST_%s.svg" % crest_type)
    $CrestCount.text = "%02d" % crest_count
