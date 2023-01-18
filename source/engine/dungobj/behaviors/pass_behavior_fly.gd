extends Node

# public functions
func is_passable(dungobj):
    """
    Return true if pass behavior allows to pass dungobj during movement.
    """
    return dungobj.is_none() or not dungobj.is_flying() 
