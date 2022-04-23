extends TextureRect

const PATHDICT = {1 : "res://art/icons/TILE_BLUE.png",
                  2 : "res://art/icons/TILE_RED.png"}

func set_tile(tile):
    match tile.NAME:
        "EMPTY": 
            texture = load("res://art/icons/TILE_BLACK.png")
        "BLOCK":
            texture = load("res://art/icons/TILE_WHITE.png")
        "PATH":
            set_path_tile(tile)
            
func set_path_tile(tile):
    var id = tile.player.id
    texture = load(PATHDICT[id])
