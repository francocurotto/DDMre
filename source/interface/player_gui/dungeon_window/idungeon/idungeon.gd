extends AspectRatioContainer

# constants
const NetCreator = preload("res://interface/player_gui/dungeon_window/idungeon/net_creator.gd")

# variables
var dungeon
var player
var itiles = []
var net_creator = NetCreator.new()
var selected_itile
var dim_dice

# onready variables
onready var rows = $Rows
onready var move_menu = $MoveMenu
onready var attack_menu = $AttackMenu
onready var reply_menu = $ReplyMenu
onready var net_select_buttons = $NetSelectButtons

# signals
signal tile_select_button_toggled(itile, pressed)
signal net_updated(can_dimension)
signal menu_opened
signal attack_cmd(cmd)
signal monster_jumped(pos1, pos2)

func _ready():
    Events.connect("duel_update", self, "update_dungeon")
    for row in rows.get_children():
        for itile in row.get_children():
            itiles.append(itile)
            itile.connect("tile_select_button_toggled", self, "on_tile_select_button_toggled")
            itile.connect("tile_move_button_pressed", self, "on_tile_move_button_pressed")
            itile.connect("tile_attack_button_pressed", self, "on_tile_attack_button_pressed")
            itile.connect("tile_jump_button_pressed", self, "on_tile_jump_button_pressed")
            itile.connect("tile_dim_button_pressed", self, "on_tile_dim_button_pressed")

# setget functions
func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    net_creator.set_playerid(player.id)
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
    disable_itile_buttons()
    disable_itile_highlights()
    enable_select_buttons()
    if selected_itile:
        selected_itile._on_TileSelectButton_toggled(false) # deselect itile
    update_dungeon()

func enable_select_buttons():
    for itile in itiles:
        itile.enable_select_button()

func disable_itile_buttons():
    for itile in itiles:
        itile.disable_all_buttons()

func disable_itile_highlights():
    for itile in itiles:
        itile.disable_all_highlights()

func unset_highlights():
    for itile in itiles:
        itile.unset_highlight()

func unset_summon_highlights():
    for itile in itiles:
        itile.unset_summon_highlight()

func open_reply_menu(attacker, attacked):
    reply_menu.activate(attacker, attacked)

func highlight_attack_reply(attacker, attacked):
    highlight_attack(attacker.tile.pos, attacked.tile.pos)

# signals callbacks
func on_tile_select_button_toggled(itile, pressed):
    assign_selected_itile(itile, pressed)
    release_unselected_itiles()
    emit_signal("tile_select_button_toggled", itile.tile.content, pressed)

func on_tile_move_button_pressed(itile):
    disable_itile_buttons()
    var pos1 = selected_itile.tile.pos
    var pos2 = itile.tile.pos
    var monster = selected_itile.tile.content
    var path = dungeon.get_move_path(pos1, pos2)
    var move_cost = dungeon.get_move_cost(path, monster)
    highlight_movement(pos1, pos2, path)
    move_menu.activate(pos1, pos2, move_cost, player)
    emit_signal("menu_opened")

func on_tile_attack_button_pressed(itile):
    var pos1 = selected_itile.tile.pos
    var pos2 = itile.tile.pos
    var attacker = selected_itile.tile.content
    var attacked = itile.tile.content
    if attacker.can_target_monster(attacked):
        highlight_attack(pos1, pos2)
        attack_menu.activate(pos1, pos2, attacker, attacked)
        emit_signal("menu_opened")
    elif attacker.can_target_ml(attacked):
        emit_signal("attack_cmd", {"name":"ATTACK", "origin":pos1, "dest":pos2})

func on_tile_jump_button_pressed(itile):
    var pos1 = selected_itile.tile.pos
    var pos2 = itile.tile.pos
    if not itile.tile.is_occupied():
        emit_signal("monster_jumped", pos1, pos2)

func on_tile_dim_button_pressed(itile):
    on_tile_select_button_toggled(itile, true)
    unset_summon_highlights()
    itile.tile_frame.summon_highlight_type = dim_dice.card.type
    net_creator.update_net_pos(itile.tile.pos)

func on_move_button_pressed():
    disable_itile_buttons()
    var move_poss = dungeon.get_move_poss(player, selected_itile.tile.pos)
    for move_pos in move_poss:
        var itile = get_itile(move_pos)
        itile.set_highlight()
        if itile.tile.is_reachable():
            itile.enable_move_button()

func on_attack_button_pressed():
    disable_itile_buttons()
    var attack_poss = dungeon.get_attack_poss(player, selected_itile.tile.pos)
    for attack_pos in attack_poss:
        get_itile(attack_pos).enable_attack_button()

func on_jump_button_pressed():
    disable_itile_buttons()
    var vortex_poss = dungeon.get_vortex_poss()
    for vortex_pos in vortex_poss:
        get_itile(vortex_pos).enable_jump_button()

func on_dice_dim_button_pressed(dice):
    disable_itile_buttons()
    dim_dice = dice
    net_creator.reset()
    for itile in itiles:
        itile.enable_dim_button()

func on_net_updated(net):
    unset_highlights()
    highlight_net(net)
    emit_signal("net_updated", dungeon.can_dimension(net, player))

func on_net_button_pressed():
    net_select_buttons.activate()

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

func highlight_movement(pos1, pos2, path):
    disable_itile_highlights()
    for pos in path:
        get_itile(pos).set_highlight()
    get_itile(pos2).tile_frame.set_dungobj_icon(get_itile(pos1).tile_frame.dungobj_type, player.id)
    get_itile(pos1).tile_frame.set_dungobj_icon("NONE", 0)

func highlight_attack(pos1, pos2):
    disable_itile_highlights()
    get_itile(pos1).set_highlight()
    get_itile(pos2).set_highlight()
