@tool
extends HBoxContainer

#region export variables
@export_range(0, 3) var hearts = 3 :
    set(_hearts):
        hearts = _hearts
        set_hearts()

@export_range(1, 2) var player = 1 :
    set(_player):
        player = _player
        set_hearts()
#endregion

#region public functions
func setup(_player):
    player = _player.id
    hearts = _player.monster_lord.hearts
#endregion

#region private functions
func set_hearts():
    for i in get_child_count():
        if i < hearts:
            var heart_icon = "res://assets/icons/HEART_P%s.svg" % player
            get_child(i).texture = load(heart_icon)
        else:
            get_child(i).texture = load("res://assets/icons/HEART_EMPTY.svg")
#endregion

