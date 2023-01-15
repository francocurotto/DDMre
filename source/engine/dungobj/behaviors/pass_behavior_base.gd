extends Reference

# is functions
func is_flying():
    return false

# public functions
func is_passable(dungobj):
    """
    Return true if pass behavior allows to pass dungobj during movement.
    """
    return dungobj.is_none() or dungobj.is_flying() 
