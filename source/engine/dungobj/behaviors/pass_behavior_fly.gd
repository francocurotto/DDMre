extends Node

# public functions
func is_passable(dungobj):
    """
    Return true if pass behavior allows to pass dungobj during movement.
    """
    return dungobj.is_none() or (dungobj.is_monster() and not dungobj.is_flying()) 
