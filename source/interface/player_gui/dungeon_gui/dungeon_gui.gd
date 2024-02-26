extends VBoxContainer

# variables
var player
var dungeon
var tile_guis = []
var tile_guis_button_group = ButtonGroup.new()

# signals
signal tile_gui_toggled

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
            tile_gui.select_button_toggled.connect(on_tile_gui_toggled)

func toggle_off_tile_gui():
    var pressed_tile_button = tile_guis_button_group.get_pressed_button()
    if pressed_tile_button != null:
        pressed_tile_button.button_pressed = false

# signals callbacks
func on_tile_gui_toggled(tile_gui, toggled_on):
    tile_gui_toggled.emit(tile_gui, toggled_on)
