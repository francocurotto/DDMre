@tool
extends PanelContainer

#region export variables
@export_enum("MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP") 
var crest_type : String = "MOVEMENT" :
    set(_crest_type):
        crest_type = _crest_type
        set_crest_info()

@export_range(0, 99) var crest_count = 0 :
    set(_crest_count):
        crest_count = _crest_count
        set_crest_info()
#endregion

#region public functions
func flash(alpha):
    var tween = create_tween()
    tween.tween_property(self, "self_modulate", Color(1,1,1,alpha), 0.3)
    return tween
#endregion

#region private functions
func set_crest_info():
    %CrestType.texture = load("res://assets/icons/CREST_%s.svg" % crest_type)
    %CrestCount.text = "%02d" % crest_count
#endregion

