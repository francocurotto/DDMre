extends AspectRatioContainer

# onready variables
onready var rows = $Rows

func _ready():
    for row in rows.get_children():
        for itile in row.get_children():
            itile.connect("tile_button_toggled", self, "on_tile_button_toggled")

# setget functions
func set_dungeon(dungeon, player):
    for i in range(rows.get_child_count()):
        var irow = get_irow(player, i)
        var row = dungeon.array[i]
        for j in range(irow.get_child_count()):
            var itile = irow.get_child(j)
            var tile = row[j]
            itile.set_tile(tile)

# signals callbacks
func on_tile_button_toggled(itile):
    for row in rows.get_children():
        for _itile in row.get_children():
            if _itile != itile:
                _itile._on_TileButton_toggled(false)

# private functions
func get_irow(player, idx):
    if player.id == 1: # v-flip dungeon for player1
        return rows.get_child(rows.get_child_count()-idx-1)
    else:
        return rows.get_child(idx)
