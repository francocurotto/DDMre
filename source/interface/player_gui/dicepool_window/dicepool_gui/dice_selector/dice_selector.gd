extends TextureRect

# variables
var move_time = 1.0

func move(pos):
    var tween = create_tween()
    tween.tween_property(self, "global_position", pos, move_time).\
        set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
