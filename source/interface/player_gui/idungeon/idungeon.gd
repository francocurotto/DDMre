extends AspectRatioContainer

# constants
const DungeonMenu = preload("res://interface/player_gui/idungeon/dungeon_menu/dungeon_menu.tscn")
const ReplyMenu = preload("res://interface/player_gui/idungeon/reply_menu/reply_menu.tscn")

# variables
var dungeon
var player
var dungeon_menu
var reply_menu

# onready variables
onready var cols = $Cols

# signals
signal mouse_entered_summon(summon)
signal mouse_exited_tile
signal mouse_entered_target(attacker, attacked)
signal move_input(pos1, pos2)
signal attack_input(pos1, pos2)
signal guard_input
signal wait_input
signal dungeon_menu_opened
signal dungeon_menu_closed

func _ready():
    for row in cols.get_children():
        for tile in row.get_children():
            tile.connect("mouse_entered_summon", self, "on_mouse_entered_summon")
            tile.connect("mouse_exited_tile", self, "on_mouse_exited_tile")
            tile.connect("monster_pressed", self, "on_monster_pressed")
            tile.connect("reachable_path_pressed", self, "on_reachable_path_pressed")
            tile.connect("attack_button_pressed", self, "on_attack_button_pressed")
            tile.connect("mouse_entered_attack_button", self, "on_mouse_entered_attack_button")

# set functions
func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    update_dungeon()

func enable_itilebuttons():
    for row in cols.get_children():
        for t in row.get_children():
            t.enable_itilebutton()

func disable_itilebuttons():
    for row in cols.get_children():
        for t in row.get_children():
            t.disable_itilebutton()

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
    enable_itilebuttons()

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

func on_monster_pressed(itile):
    if itile.tile.content in player.monsters:
        create_dungeon_menu(itile)

func on_reachable_path_pressed(itile):
    var pos1 = dungeon_menu.itile.tile.pos
    var pos2 = itile.tile.pos
    emit_signal("move_input", pos1, pos2)
    dungeon_menu.queue_free()

func on_attack_button_pressed(itile):
    if itile.tile.content.is_target():
        if itile.tile.content.player != player:
            var pos1 = dungeon_menu.itile.tile.pos
            var pos2 = itile.tile.pos
            emit_signal("attack_input", pos1, pos2)
            dungeon_menu.queue_free()

func on_mouse_entered_attack_button(content):
    if content.is_summon():
        if content.player != player:
            emit_signal("mouse_entered_target", dungeon_menu.itile.tile.content, content)

func on_dmenu_enabled():
    unset_all_itile_mods()
    disable_itilebuttons()
    emit_signal("dungeon_menu_opened")

func on_dmenu_move_pressed(itile):
    dungeon_menu.disable()
    var moveposs = dungeon.get_moveposs(player, itile.tile.pos)
    for movepos in moveposs:
        get_itile(movepos).set_movetile()

func on_dmenu_attack_pressed(itile):
    dungeon_menu.disable()
    var attackposs = dungeon.get_attackposs(player, itile.tile.pos)
    for attackpos in attackposs:
        get_itile(attackpos).set_attacktile()

func on_dmenu_cancel_pressed():
    dungeon_menu.queue_free()
    enable_itilebuttons()
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

func create_dungeon_menu(itile):
    dungeon_menu = DungeonMenu.instance()
    add_child(dungeon_menu)
    dungeon_menu.connect("dmenu_move_pressed", self, "on_dmenu_move_pressed")
    dungeon_menu.connect("dmenu_attack_pressed", self, "on_dmenu_attack_pressed")
    dungeon_menu.connect("dmenu_cancel_pressed", self, "on_dmenu_cancel_pressed")
    dungeon_menu.connect("dmenu_enabled", self, "on_dmenu_enabled")
    dungeon_menu.set_dungeon_menu(itile, player)   
