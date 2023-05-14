extends AspectRatioContainer

# constants
const NetCreator = preload("res://interface/player_gui/dungeon_window/dungeon_gui/net_creator.gd")

# variables
var dungeon
var player
var net_creator = NetCreator.new()
var dim_dice
var tile_guis = []
var selected_tile_gui

# onready variables
onready var rows = $Rows
onready var action_menu = $ActionMenu

# signals
signal tile_select_button_toggled(content, pressed)
signal net_updated(can_dimension)
signal menu_opened
signal tile_move_button_pressed(pos1, pos2, move_cost)
signal attack_monster_lord(cmd)
signal monster_jumped(pos1, pos2)

func _ready():
    Events.connect("duel_update", self, "update_dungeon")
    for row in rows.get_children():
        for tile_gui in row.get_children():
            tile_guis.append(tile_gui)
            tile_gui.connect("tile_select_button_toggled", self, "on_tile_select_button_toggled")
            tile_gui.connect("tile_move_button_pressed", self, "on_tile_move_button_pressed")
            tile_gui.connect("tile_attack_button_pressed", self, "on_tile_attack_button_pressed")
            tile_gui.connect("tile_jump_button_pressed", self, "on_tile_jump_button_pressed")
            tile_gui.connect("tile_dim_button_pressed", self, "on_tile_dim_button_pressed")

# setget functions
func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    net_creator.set_playerid(player.id)
    update_dungeon()

# public functions
func update_dungeon():
    for i in range(rows.get_child_count()):
        var row_gui = get_row_gui(i)
        var row = dungeon.array[i]
        for j in range(row_gui.get_child_count()):
            var tile_gui = row_gui.get_child(j)
            var tile = row[j]
            tile_gui.set_tile(tile)

func reset():
    disable_tile_gui_buttons()
    disable_tile_gui_highlights()
    enable_select_buttons()
    diselect_tile_gui()
    update_dungeon()
    action_menu.visible = false

func diselect_tile_gui():
    if selected_tile_gui:
        selected_tile_gui._on_TileSelectButton_toggled(false) # deselect tile_gui

func enable_select_buttons():
    for tile_gui in tile_guis:
        tile_gui.enable_select_button()

func disable_tile_gui_buttons():
    for tile_gui in tile_guis:
        tile_gui.disable_all_buttons()

func disable_tile_gui_highlights():
    for tile_gui in tile_guis:
        tile_gui.disable_all_highlights()

func disable_tile_gui_ability_highlights():
    for tile_gui in tile_guis:
        tile_gui.set_ability_highlight(false)

func set_ability_select_highlights(tiles):
    for tile in tiles:
        get_tile_gui(tile.pos).set_ability_select_highlight(true)

func unset_highlights():
    for tile_gui in tile_guis:
        tile_gui.highlight = false

func unset_summon_highlights():
    for tile_gui in tile_guis:
        tile_gui.set_summon_highlight_type("NONE")

func unset_ability_select_highlights():
    for tile_gui in tile_guis:
        tile_gui.set_ability_select_highlight(false)

func activate_reply_gui(attacker, attacked):
    action_menu.activate_reply_gui(attacker, attacked)

func activate_state_ability_gui(state):
    disable_tile_gui_buttons()
    disable_tile_gui_highlights()
    action_menu.activate_state_ability_gui(state)

func highlight_attack_reply(attacker, attacked):
    highlight_attack(attacker.tile.pos, attacked.tile.pos)

func hide_menus():
    action_menu.visible = false

func show_menus():
    action_menu.visible = true

# signals callbacks
func on_tile_select_button_toggled(tile_gui, pressed):
    assign_selected_tile_gui(tile_gui, pressed)
    release_unselected_tile_guis()
    emit_signal("tile_select_button_toggled", tile_gui.tile, pressed)

func on_tile_move_button_pressed(tile_gui):
    disable_tile_gui_buttons()
    var pos1 = selected_tile_gui.tile.pos
    var pos2 = tile_gui.tile.pos
    var monster = selected_tile_gui.tile.content
    var path = dungeon.get_move_path(pos1, pos2)
    var move_cost = dungeon.get_move_cost(path, monster)
    highlight_movement(pos1, pos2, path)
    emit_signal("tile_move_button_pressed", pos1, pos2, move_cost)

func on_tile_attack_button_pressed(tile_gui):
    var pos1 = selected_tile_gui.tile.pos
    var pos2 = tile_gui.tile.pos
    var attacker = selected_tile_gui.tile.content
    var attacked = tile_gui.tile.content
    if attacker.can_target_monster(attacked):
        highlight_attack(pos1, pos2)
        action_menu.activate_attack_gui(attacker, attacked)
        emit_signal("menu_opened")
    elif attacker.can_target_ml(attacked):
        emit_signal("attack_monster_lord", pos1, pos2, null)

func on_tile_dim_button_pressed(tile_gui):
    on_tile_select_button_toggled(tile_gui, true)
    unset_summon_highlights()
    tile_gui.summon_highlight_type = dim_dice.card.type
    net_creator.update_net_pos(tile_gui.tile.pos)

func on_tile_jump_button_pressed(tile_gui):
    var pos1 = selected_tile_gui.tile.pos
    var pos2 = tile_gui.tile.pos
    if not tile_gui.tile.is_occupied():
        emit_signal("monster_jumped", pos1, pos2)

func on_dice_dim_button_pressed(dice):
    disable_tile_gui_buttons()
    dim_dice = dice
    net_creator.reset()
    for tile_gui in tile_guis:
        tile_gui.enable_dim_button()

func on_move_button_pressed():
    disable_tile_gui_buttons()
    var move_poss = dungeon.get_move_poss(player, selected_tile_gui.tile.pos)
    for move_pos in move_poss:
        var tile_gui = get_tile_gui(move_pos)
        if tile_gui.tile.is_reachable():
            tile_gui.enable_move_button()

func on_attack_button_pressed():
    disable_tile_gui_buttons()
    var attack_poss = dungeon.get_attack_poss(selected_tile_gui.tile.pos)
    for attack_pos in attack_poss:
        get_tile_gui(attack_pos).enable_attack_button()

func on_ability_button_pressed():
    disable_tile_gui_buttons()
    var standing_ability
    for ability in selected_tile_gui.tile.content.card.abilities:
        if ability.is_standing():
            standing_ability = ability
    action_menu.activate_standing_ability_gui(standing_ability)

func on_jump_button_pressed():
    disable_tile_gui_buttons()
    var vortex_poss = dungeon.get_vortex_poss()
    for vortex_pos in vortex_poss:
        get_tile_gui(vortex_pos).enable_jump_button()

func on_net_updated(net):
    unset_highlights()
    highlight_net(net)
    emit_signal("net_updated", dungeon.can_dimension(net, player))

func on_FLR_button_pressed():
    net_creator.update_net_flr()

func on_FUD_button_pressed():
    net_creator.update_net_fud()

func on_TCW_button_pressed():
    net_creator.update_net_tcw()

func on_TAW_button_pressed():
    net_creator.update_net_taw()

func on_select_tile_cancel_button_pressed():
    disable_tile_gui_buttons()
    unset_ability_select_highlights()
    action_menu.on_select_tile_cancel_button_pressed()

func on_select_tile_select_button_pressed():
    disable_tile_gui_buttons()    
    unset_ability_select_highlights()
    action_menu.on_select_tile_select_button_pressed(selected_tile_gui.tile)

func on_select_direction_select_button_pressed(direction):
    action_menu.on_select_direction_select_button_pressed(direction)

func on_highlight_ability_tiles(tiles):
    disable_tile_gui_ability_highlights()
    for tile in tiles:
        get_tile_gui(tile.pos).set_ability_highlight(true)

# private functions
func get_row_gui(idx):
    if player.id == 1: # v-flip dungeon for player1
        return rows.get_child(rows.get_child_count()-idx-1)
    else:
        return rows.get_child(idx)

func get_tile_gui(pos):
    if player.id == 1:
        return rows.get_child(rows.get_child_count()-pos.y-1).get_child(pos.x)
    else: # player.id == 2
        return rows.get_child(pos.y).get_child(pos.x)

func assign_selected_tile_gui(tile_gui, pressed):
    if pressed:
        selected_tile_gui = tile_gui
    else:
        selected_tile_gui = null

func release_unselected_tile_guis():
    for tile_gui in tile_guis:
        if tile_gui != selected_tile_gui:
            tile_gui.release_select_button()

func highlight_net(net):
    for pos in net.poslist:
        if dungeon.pos_within_dungeon(pos):
            get_tile_gui(pos).highlight = true

func highlight_movement(pos1, pos2, path):
    disable_tile_gui_highlights()
    for pos in path:
        get_tile_gui(pos).highlight = true
    get_tile_gui(pos2).set_dungobj_icon(get_tile_gui(pos1).dungobj_type, player.id)
    get_tile_gui(pos1).set_dungobj_icon("NONE", 0)

func highlight_attack(pos1, pos2):
    disable_tile_gui_highlights()
    disable_tile_gui_buttons()
    get_tile_gui(pos1).attack_highlight = true
    get_tile_gui(pos2).attack_highlight = true
