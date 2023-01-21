extends "res://engine/dungobj/behaviors/target_behavior_base.gd"

func _init(_player).(_player):
    pass

# private functions
func can_target_monster(dungobj):
    """
    Return true if dungobj is monster and can be target.
    """
    return dungobj.is_monster() and dungobj.player != player
