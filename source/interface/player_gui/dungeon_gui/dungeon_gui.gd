extends VBoxContainer

# variables
var player
var dungeon
var tile_guis = []
var selected_tile_gui
var tile_guis_button_group = ButtonGroup.new()

func _ready():
    tile_guis_button_group.allow_unpress = true

# public functions
func setup(_player, _dungeon):
    player = _player
    dungeon = _dungeon
    # get row guis
    var rows = get_children()
    if player.id == 1: # reverse row orientation if player 1
        rows.reverse()
    for i in len(rows):
        var row = rows[i].get_children()
        for j in len(row):
            var tile = dungeon.grid[i][j]
            var tile_gui = row[j]
            tile_gui.setup(tile)
            tile_gui.tile_icon.button_group = tile_guis_button_group
