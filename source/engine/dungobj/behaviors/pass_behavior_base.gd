extends Reference

# public functions
func is_passable(tile):
    """
    Return true if pass behavior allows to pass dungobj during movement.
    """
    return tile.is_empty() or tile.content.is_flying() 
