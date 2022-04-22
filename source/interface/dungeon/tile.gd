extends TextureRect

func set_tile(tile):
    match tile.NAME:
        "EMPTY": 
            texture = load("res://art/icons/TILE_BLACK.png")
        "BLOCK":
            texture = load("res://art/icons/TILE_WHITE.png")
        "PATH":
            if tile.player.id == 1:
                texture = load("res://art/icons/TILE_BLUE.png")
            elif tile.player.id == 2:
                texture = load("res://art/icons/TILE_RED.png")
