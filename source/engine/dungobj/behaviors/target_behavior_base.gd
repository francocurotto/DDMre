extends Reference

var player

func _init(_player):
    player = _player

# public functions
func can_target_ml(dungobj):
    """
    Return true if dungobj is monster lord and can be target.
    """
    return dungobj.is_monster_lord() and dungobj.player != player

func can_target_monster(dungobj):
    """
    Return true if dungobj is monster and can be target.
    """
    return dungobj.is_monster() and not dungobj.is_flying() and dungobj.player != player
