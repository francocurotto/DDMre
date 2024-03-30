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
@onready var dim_tile = $Rows/Row4/TileGui7

# signals
signal tile_gui_toggled
signal dimension_net_changed

func _ready():
    tile_guis_button_group.allow_unpress = true

# public functions
func setup(_player, _dungeon):
    player = _player
    dungeon = _dungeon
    for rows in $Rows.get_children():
        for tile_gui in rows.get_children():
            # tile gui button group
            tile_gui.path_tile.button_group = tile_guis_button_group
            tile_gui.select_button_toggled.connect(on_tile_gui_toggled)
            # tile gui dim button_group
            tile_gui.dim_button.button_group = dim_button_group
            tile_gui.dim_button_toggled.connect(on_tile_dim_button_toggled)
            tile_guis.append(tile_gui)
    update()

func update():
    # get row guis
    for i in $Rows.get_child_count():
        for j in $Rows.get_child(0).get_child_count():
            var tile = dungeon.grid[i][j]
            var tile_gui = get_tile_gui(Vector2i(j,i))
            tile_gui.setup(tile)

func get_dim_params():
    var dim_params = {
        "net" : dimension_net.net.substr(0,2),
        "pos" : get_tile_gui_position(dim_tile),
        "trans" : dimension_net.get_trans_list()}
    return dim_params

func on_dice_dimensioned(_summon, net):
    # remove dimension net if exists
    if is_instance_valid(dimension_net):
        dimension_net.queue_free()
    # hide tile guis for proper animation
    for pos in net.poslist:
        get_tile_gui(pos).path_tile.modulate = Color(1,1,1,0)
    # make center tile appear
    var tile_gui = get_tile_gui(net.centerpos)
    var tile = dungeon.get_tile(net.centerpos)
    var tween = create_tween()
    tile_gui.tween_dim_appear(tween, tile)
    # make subsequent tiles fold
    for i in range(len(net.poslist)-1):
        tile_gui = get_tile_gui(net.poslist[i+1])
        tile = dungeon.get_tile(net.poslist[i+1])
        var unfold = net.unfolds[i]
        tile_gui.tween_dim_fold(tween, tile, unfold)

# signals callbacks
func on_tile_gui_toggled(tile_gui, toggled_on):
    tile_gui_toggled.emit(tile_gui, toggled_on)

func on_tile_dim_button_toggled(tile_gui, toggled_on):
    if toggled_on:
        dim_tile = tile_gui
        dimension_net.global_position = tile_gui.global_position
        on_dimension_net_changed()

func on_dimension_net_changed():
    var net = dimension_net.get_net()
    net.add_offset(get_tile_gui_position(dim_tile))
    dimension_net_changed.emit(dungeon.can_dimension(net, player))

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
    dimension_net.net_changed.connect(on_dimension_net_changed)
    # enable dim buttons
    enable_dim_buttons()
    # move to starting position
    dim_tile._on_dim_button_toggled(true)

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

func get_tile_gui(pos):
    var y = pos.y
    if player.id == 1: # correct for player 2 reflection
        y = $Rows.get_child_count() - pos.y - 1
    var row = $Rows.get_child(y)
    var tile_gui = row.get_child(pos.x)
    return tile_gui

func get_tile_gui_position(tile_gui):
    var x = tile_gui.get_index()
    var y = tile_gui.get_parent().get_index()
    if player.id == 1:
        y = $Rows.get_child_count() - y - 1
    return Vector2i(x,y)
