extends VBoxContainer

# variables
var player
var dungeon
var tile_guis = []
var selected_tile_gui

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
            tile_gui.select_button_toggled.connect(on_select_button_toggled)

# signals callbacks
func on_select_button_toggled(tile_gui, toggled_on):
    if toggled_on:
        if selected_tile_gui != tile_gui:
            if selected_tile_gui:
                selected_tile_gui.select_tile(false)
            selected_tile_gui = tile_gui
    else:
        selected_tile_gui = null
