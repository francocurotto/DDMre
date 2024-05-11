extends PanelContainer

#region signals
signal tile_gui_pressed
signal net_gui_changed
#endregion

#region constants
const NetGUI = preload("res://interface/player_gui/dungeon_gui/net_gui/net_gui.tscn")
#endregion

#region variables
var engine
var player
var dungeon
var tile_guis = []
var net_gui
var tile_guis_button_group = ButtonGroup.new()
#endregion

#region onready variables
@onready var dim_tile = $Rows/Row4/TileGui7
#endregion 

#region public functions
func setup(_engine, _player):
    engine = _engine
    player = _player
    dungeon = engine.state.dungeon
    for i in Globals.DUNGEON_HEIGHT:
        for j in Globals.DUNGEON_WIDTH:
            # get tile and tile gui
            var tile = dungeon.grid[i][j]
            var tile_gui = get_tile_gui(Vector2i(j,i))
            # setup tile guis with tiles
            tile_gui.setup(tile)
            # add tile guis to button group
            tile_gui.select_button.button_group = tile_guis_button_group
            tile_gui.select_button_pressed.connect(on_tile_gui_pressed)

func get_dim_params():
    var dim_params = {
        "net"   : net_gui.get_net_name(),
        "pos"   : get_tile_gui_position(dim_tile),
        "trans" : net_gui.get_trans_list()}
    return dim_params
#endregion

#region signals callbacks
func on_dicepool_button_activated():
    toggle_off_tile_gui()
    disable_tile_guis()
    remove_net_gui()

func on_dicepool_button_deactivated():
    enable_tile_guis()

func on_tile_gui_pressed(tile_gui):
    tile_gui_pressed.emit(tile_gui)
    # case pressed during dimension
    if engine.state.NAME == "DIMENSION":
        dim_tile = tile_gui
        net_gui.global_position = tile_gui.global_position
        on_net_gui_changed()

func on_net_gui_changed():
    var net = net_gui.get_net()
    net.add_offset(get_tile_gui_position(dim_tile))
    net_gui_changed.emit(dungeon.can_dimension(net, player))

func on_summon_button_pressed(dice_gui):
    # create dimension net
    net_gui = NetGUI.instantiate()
    net_gui.summon_type = dice_gui.dice.card.type
    add_child(net_gui)
    net_gui.net_changed.connect(on_net_gui_changed)
    on_tile_gui_pressed(dim_tile)

func on_dice_dimensioned(net):
    # remove net gui
    remove_net_gui()
    # hide tile guis for proper animation
    for pos in net.positions:
        get_tile_gui(pos).path_tile.modulate = Color(1,1,1,0)
    # make center tile appear
    var tile_gui = get_tile_gui(net.center)
    var tile = dungeon.get_tile(net.center)
    var tween = create_tween()
    tile_gui.tween_dim_appear(tween, tile)
    # make subsequent tiles fold
    for i in range(len(net.positions)-1):
        tile_gui = get_tile_gui(net.positions[i+1])
        tile = dungeon.get_tile(net.positions[i+1])
        var unfold = net.unfolds[i]
        tile_gui.tween_dim_fold(tween, tile, unfold)
#endregion

#region private functions
func toggle_off_tile_gui():
    var pressed_tile_button = tile_guis_button_group.get_pressed_button()
    if pressed_tile_button != null:
        pressed_tile_button.button_pressed = false

func disable_tile_guis():
    for tile_gui in tile_guis:
        tile_gui.disabled = true

func enable_tile_guis():
    for tile_gui in tile_guis:
        tile_gui.disabled = false

func get_tile_gui(pos):
    var y = pos.y
    if player.id == 1: # correct for player 1 reflection of dungeon rows
        y = $Rows.get_child_count() - pos.y - 1
    var row = $Rows.get_child(y)
    var tile_gui = row.get_child(pos.x)
    return tile_gui

func get_tile_gui_position(tile_gui):
    var x = tile_gui.get_index()
    var y = tile_gui.get_parent().get_index()
    if player.id == 1: # correct for player 1 reflection of dungeon rows
        y = $Rows.get_child_count() - y - 1
    return Vector2i(x,y)

func remove_net_gui():
    # remove net gui only if exists
    if is_instance_valid(net_gui):
        net_gui.queue_free()
#endregion
