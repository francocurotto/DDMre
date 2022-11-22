tool
extends MarginContainer

# export variables
export (String, "NONE", "ML1", "ML2") var ml = "NONE" setget set_ml

# setget functions
func set_ml(_ml):
    ml = _ml
    if ml == "NONE":
        $TileFrame.set_tile_icon("EMPTY", 0)
        $TileFrame.set_dungobj_icon("NONE", 0)
    elif ml == "ML1":
        $TileFrame.set_tile_icon("PATH", 1)
        $TileFrame.set_dungobj_icon("MONSTER_LORD", 1)
    elif ml == "ML2":
        $TileFrame.set_tile_icon("PATH", 2)
        $TileFrame.set_dungobj_icon("MONSTER_LORD", 2)
