extends "dungobj.gd"
## A dungobj used to represent the absence of an object (i.e. null value).

#region constants
const TYPE = "NONE"
#endregion

#region is functions
func is_none():
    return true
#endregion
