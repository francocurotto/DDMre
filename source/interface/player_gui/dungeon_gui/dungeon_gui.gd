extends VBoxContainer

# variables
var player
var dungeon

# pubic functions
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
        
