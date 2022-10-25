extends AspectRatioContainer

# constants
const DungeonMenu = preload("res://interface/player_gui/idungeon/dungeon_menu/dungeon_menu.tscn")
const ReplyMenu = preload("res://interface/player_gui/idungeon/reply_menu/reply_menu.tscn")
const NetCreator = preload("res://interface/player_gui/idungeon/net_creator.gd")

# variables
var dungeon
var player
var dimdice
var dungeon_menu
var reply_menu
var net_creator

# onready variables
onready var cols = $Cols

# signals
signal mouse_entered_summon(summon)
signal mouse_exited_tile
signal mouse_entered_target(attacker, attacked)
signal dim_input(net, pos, trans)
signal move_input(pos1, pos2)
signal attack_input(pos1, pos2)
signal guard_input
signal wait_input
signal dungeon_menu_opened
signal dungeon_menu_closed

func _ready():
    for row in cols.get_children():
        for itile in row.get_children():
            itile.connect("mouse_entered_summon", self, "on_mouse_entered_summon")
            itile.connect("mouse_exited_tile", self, "on_mouse_exited_tile")
            itile.connect("monster_pressed", self, "on_monster_pressed")
            itile.connect("mouse_entered_dim", self, "on_mouse_entered_dim")
            itile.connect("mouse_exited_dim", self, "on_mouse_exited_dim")
            itile.connect("dim_button_pressed", self, "on_dim_button_pressed")
            itile.connect("reachable_path_pressed", self, "on_reachable_path_pressed")
            itile.connect("attack_button_pressed", self, "on_attack_button_pressed")
            itile.connect("mouse_entered_attack_button", self, "on_mouse_entered_attack_button")

# setget functions
func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    update_dungeon()

func enable_tile_buttons():
    for row in cols.get_children():
        for itile in row.get_children():
            itile.enable_tile_button()

func disable_tile_buttons():
    for row in cols.get_children():
        for itile in row.get_children():
            itile.disable_tile_button()

func set_dim_buttons():
    for row in cols.get_children():
        for itile in row.get_children():
            itile.set_dim_button()

func unset_highlights():
    for row in cols.get_children():
        for itile in row.get_children():
            itile.unset_highlight()

func unset_all_itile_mods():
    for row in cols.get_children():
        for itile in row.get_children():
            itile.unset_all_mods()

# public functions
func update_dungeon():
    for i in range(cols.get_child_count()):
        var row = dungeon.array[i]
        if player.id == 1: i = cols.get_child_count()-1-i # v-flip dungeon for player1
        var irow = cols.get_child(i)
        for j in range(irow.get_child_count()):
            var tile = row[j]
            var itile = irow.get_child(j)
            itile.set_tile(tile)
    unset_all_itile_mods()
    enable_tile_buttons()

func mark_reply_monsters(reply_state):
    var poss = reply_state.get_monsters_poss()
    for pos in poss:
        get_itile(pos).set_highlight()

func create_reply_menu(reply_state):
    reply_menu = ReplyMenu.instance()
    add_child(reply_menu)
    reply_menu.connect("rmenu_guard_pressed", self, "on_rmenu_guard_pressed")
    reply_menu.connect("rmenu_wait_pressed", self, "on_rmenu_wait_pressed")
    reply_menu.set_reply_menu(reply_state)

# signals callbacks
func on_mouse_entered_summon(summon):
    emit_signal("mouse_entered_summon", summon)

func on_mouse_exited_tile():
    emit_signal("mouse_exited_tile")

func on_monster_pressed(tile):
    if tile.content in player.monsters:
        create_dungeon_menu(tile)

func on_dimdice_selected(idx):
    dimdice = idx
    net_creator = NetCreator.new(player.id)
    net_creator.connect("net_updated", self, "on_net_updated")
    add_child(net_creator)
    set_dim_buttons()

func on_dimdice_unselected():
    unset_all_itile_mods()

func on_mouse_entered_dim(_pos):
    var net = net_creator.create_net(_pos)
    for pos in net.poslist:
        if dungeon.pos_within_dungeon(pos):
            get_itile(pos).set_highlight()

func on_mouse_exited_dim():
    net_creator.active = false
    unset_highlights()

func on_net_updated(pos):
    unset_highlights()
    on_mouse_entered_dim(pos)

func on_dim_button_pressed(tile):
    var netdata = net_creator.get_netdata()
    var netname = netdata["netname"]
    var trans_list = netdata["trans_list"]
    emit_signal("dim_input", dimdice, netname, tile.pos, trans_list)

func on_reachable_path_pressed(tile):
    var pos1 = dungeon_menu.tile.pos
    var pos2 = tile.pos
    emit_signal("move_input", pos1, pos2)
    dungeon_menu.queue_free()

func on_attack_button_pressed(tile):
    if tile.content.is_target():
        if tile.content.player != player:
            var pos1 = dungeon_menu.tile.pos
            var pos2 = tile.pos
            emit_signal("attack_input", pos1, pos2)
            dungeon_menu.queue_free()

func on_mouse_entered_attack_button(content):
    if content.is_summon():
        if content.player != player:
            emit_signal("mouse_entered_target", dungeon_menu.tile.content, content)

func on_dungmenu_enabled():
    unset_all_itile_mods()
    disable_tile_buttons()
    emit_signal("dungeon_menu_opened")

func on_dungmenu_move_pressed(tile):
    dungeon_menu.disable()
    var moveposs = dungeon.get_moveposs(player, tile.pos)
    for movepos in moveposs:
        get_itile(movepos).set_move_tile()

func on_dungmenu_attack_pressed(tile):
    dungeon_menu.disable()
    var attackposs = dungeon.get_attackposs(player, tile.pos)
    for attackpos in attackposs:
        get_itile(attackpos).set_attack_tile()

func on_dungmenu_cancel_pressed():
    dungeon_menu.queue_free()
    enable_tile_buttons()
    emit_signal("dungeon_menu_closed")

func on_rmenu_guard_pressed():
    reply_menu.queue_free()
    emit_signal("guard_input")

func on_rmenu_wait_pressed():
    reply_menu.queue_free()
    emit_signal("wait_input")

# private
func get_itile(pos):
    if player.id == 1:
        return cols.get_child(cols.get_child_count()-pos.y-1).get_child(pos.x)
    else: # player.id == 2
        return cols.get_child(pos.y).get_child(pos.x)

func create_dungeon_menu(tile):
    dungeon_menu = DungeonMenu.instance()
    add_child(dungeon_menu)
    dungeon_menu.connect("dungmenu_move_pressed", self, "on_dungmenu_move_pressed")
    dungeon_menu.connect("dungmenu_attack_pressed", self, "on_dungmenu_attack_pressed")
    dungeon_menu.connect("dungmenu_cancel_pressed", self, "on_dungmenu_cancel_pressed")
    dungeon_menu.connect("dungmenu_enabled", self, "on_dungmenu_enabled")
    dungeon_menu.set_dungeon_menu(tile, player)   
