extends PanelContainer

# constants
const DimensionNet = preload("res://interface/player_gui/dungeon_gui/dimension_net/dimension_net.tscn")

# variables
var player
var dungeon
var tile_guis = []
var dimension_net
var tile_guis_button_group = ButtonGroup.new()
var dim_button_group = ButtonGroup.new()

# onready variables
@onready var dim_start = $Rows/Row4/TileGui7

# signals
signal tile_gui_toggled
signal tile_dim_button_pressed

func _ready():
    tile_guis_button_group.allow_unpress = true

# public functions
func setup(_player, _dungeon):
    player = _player
    dungeon = _dungeon
    # get row guis
    var rows = $Rows.get_children()
    if player.id == 1: # reverse row orientation if player 1
        rows.reverse()
    for i in len(rows):
        var row = rows[i].get_children()
        for j in len(row):
            var tile = dungeon.grid[i][j]
            var tile_gui = row[j]
            tile_gui.setup(tile)
            # tile gui button group
            tile_gui.path_tile.button_group = tile_guis_button_group
            tile_gui.select_button_toggled.connect(on_tile_gui_toggled)
            # tile gui dim button_group
            tile_gui.dim_button.button_group = dim_button_group
            tile_gui.dim_button_toggled.connect(on_tile_dim_button_toggled)
            tile_guis.append(tile_gui)

# signals callbacks
func on_tile_gui_toggled(tile_gui, toggled_on):
    tile_gui_toggled.emit(tile_gui, toggled_on)

func on_tile_dim_button_toggled(tile_gui, toggled_on):
    if toggled_on:
        dimension_net.global_position = tile_gui.global_position
        var net = dimension_net.get_net()
        net.add_offset(get_tile_gui_position(tile_gui))
        tile_dim_button_pressed.emit(dungeon.can_dimension(net, player))

func on_dicepool_button_activated():
    toggle_off_tile_gui()
    disable_tile_guis()
    if $DimensionNode.get_child_count():
        $DimensionNode.get_child(0).queue_free()

func on_dicepool_button_deactivated():
    enable_tile_guis()

func on_summon_button_pressed(dice_gui):
    # create dimension net
    dimension_net = DimensionNet.instantiate()
    dimension_net.summon_type = dice_gui.dice.card.type
    $DimensionNode.add_child(dimension_net)
    # enable dim buttons
    enable_dim_buttons()
    # move to starting position
    on_tile_dim_button_toggled(dim_start, true)

# private functions
func toggle_off_tile_gui():
    var pressed_tile_button = tile_guis_button_group.get_pressed_button()
    if pressed_tile_button != null:
        pressed_tile_button.button_pressed = false

func disable_tile_guis():
    for tile_gui in tile_guis:
        tile_gui.disabled = true
        tile_gui.dim_button.visible = false

func enable_tile_guis():
    for tile_gui in tile_guis:
        tile_gui.disabled = false

func enable_dim_buttons():
    for tile_gui in tile_guis:
        tile_gui.dim_button.visible = true

func get_tile_gui_position(tile_gui):
    var x = tile_gui.get_index()
    var y = tile_gui.get_parent().get_index()
    if player.id == 1:
        y = $Rows.get_child_count() - y
    return Vector2i(y,x)
