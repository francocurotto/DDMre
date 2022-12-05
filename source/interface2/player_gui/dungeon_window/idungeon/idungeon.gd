extends AspectRatioContainer

# constants
const NetCreator = preload("res://interface2/player_gui/dungeon_window/idungeon/net_creator.gd")

# variables
var dungeon
var player
var selected_itile
var itiles = []
var net_creator

# onready variables
onready var rows = $Rows
onready var move_menu = $MoveMenu
onready var net_select_buttons = $NetSelectButtons

# signals
signal tile_select_button_toggled(itile, pressed)
signal tile_dim_button_pressed
signal net_updated(can_dimension)
signal menu_opened

func _ready():
    Events.connect("duel_update", self, "update_dungeon")
    net_select_buttons.connect("net_select_button_pressed", self, "on_net_select_button_pressed")
    for row in rows.get_children():
        for itile in row.get_children():
            itiles.append(itile)
            itile.connect("tile_select_button_toggled", self, "on_tile_select_button_toggled")
            itile.connect("tile_move_button_pressed", self, "on_tile_move_button_pressed")
            itile.connect("tile_dim_button_pressed", self, "on_tile_dim_button_pressed")

# setget functions
func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    update_dungeon()

# public functions
func update_dungeon():
    for i in range(rows.get_child_count()):
        var irow = get_irow(i)
        var row = dungeon.array[i]
        for j in range(irow.get_child_count()):
            var itile = irow.get_child(j)
            var tile = row[j]
            itile.set_tile(tile)

func reset():
    disable_all_buttons()
    enable_select_buttons()
    if selected_itile:
        selected_itile._on_TileSelectButton_toggled(false) # deselect itile

func enable_select_buttons():
    for itile in itiles:
        itile.enable_select_button()

func disable_all_buttons():
    for itile in itiles:
        itile.disable_all_buttons()

func unset_highlights():
    for itile in itiles:
        itile.unset_highlight()

# signals callbacks
func on_tile_select_button_toggled(itile, pressed):
    assign_selected_itile(itile, pressed)
    release_unselected_itiles()
    emit_signal("tile_select_button_toggled", itile.tile.content, pressed)

func on_tile_move_button_pressed(itile):
    var pos1 = selected_itile.tile.pos
    var pos2 = itile.tile.pos
    var path = dungeon.get_movepath(pos1, pos2)
    move_menu.activate(pos1, pos2, path, player)
    emit_signal("menu_opened")

func on_tile_dim_button_pressed(itile):
    on_tile_select_button_toggled(itile, true)
    net_creator.update_net_pos(itile.tile.pos)
    emit_signal("tile_dim_button_pressed")

func on_move_button_pressed():
    disable_all_buttons()
    var moveposs = dungeon.get_moveposs(player, selected_itile.tile.pos)
    for movepos in moveposs:
        get_itile(movepos).enable_move_button()

func on_attack_button_pressed():
    disable_all_buttons()
    var attackposs = dungeon.get_attackposs(player, selected_itile.tile.pos)
    for attackpos in attackposs:
        get_itile(attackpos).enable_attack_button()

func on_dice_dim_button_pressed():
    disable_all_buttons()
    net_creator = NetCreator.new(player.id)
    net_creator.connect("net_updated", self, "on_net_updated")
    for itile in itiles:
        itile.enable_dim_button()

func on_net_updated(net):
    unset_highlights()
    highlight_net(net)
    emit_signal("net_updated", dungeon.can_dimension(net, player))

func on_net_button_pressed():
    net_select_buttons.visible = true

func on_net_select_button_pressed(netidx):
    net_creator.update_netidx(netidx)

func on_FLR_button_pressed():
    net_creator.update_net_flr()

func on_FUD_button_pressed():
    net_creator.update_net_fud()

func on_TCW_button_pressed():
    net_creator.update_net_tcw()

func on_TAW_button_pressed():
    net_creator.update_net_taw()

# private functions
func get_irow(idx):
    if player.id == 1: # v-flip dungeon for player1
        return rows.get_child(rows.get_child_count()-idx-1)
    else:
        return rows.get_child(idx)

func get_itile(pos):
    if player.id == 1:
        return rows.get_child(rows.get_child_count()-pos.y-1).get_child(pos.x)
    else: # player.id == 2
        return rows.get_child(pos.y).get_child(pos.x)

func assign_selected_itile(itile, pressed):
    if pressed:
        selected_itile = itile
    else:
        selected_itile = null

func release_unselected_itiles():
    for itile in itiles:
        if itile != selected_itile:
            itile.release_select_button()

func highlight_net(net):
    for pos in net.poslist:
        if dungeon.pos_within_dungeon(pos):
            get_itile(pos).tile_frame.highlight = true