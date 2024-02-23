extends TextureRect

# variables
var move_time = 0.5

func move(init_pos, dest_pos):
    var tween = create_tween()
    tween.tween_property(self, "global_position", dest_pos, move_time)\
        .from(init_pos).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
