extends AspectRatioContainer

# variables
var dungeon
var player
var selected_itile = null

# onready variables
onready var cols = $Cols
onready var dungeon_menu = $DungeonMenu

# signals
signal mouse_entered_summon(summon)
signal mouse_exited_tile
signal move_input(pos1, pos2)
signal attack_input(pos1, pos2)
signal dungeon_menu_enabled
signal dungeon_menu_canceled

func _ready():
    for row in cols.get_children():
        for t in row.get_children():
            t.connect("mouse_entered_summon", self, "on_mouse_entered_summon")
            t.connect("mouse_exited_tile", self, "on_mouse_exited_tile")
            t.connect("monster_pressed", self, "on_monster_pressed")
            t.connect("reachable_path_pressed", self, "on_reachable_path_pressed")
            t.connect("target_pressed", self, "on_target_pressed")
    dungeon_menu.connect("dmenu_move_pressed", self, "on_dmenu_move_pressed")
    dungeon_menu.connect("dmenu_attack_pressed", self, "on_dmenu_attack_pressed")
    dungeon_menu.connect("dmenu_cancel_pressed", self, "on_dmenu_cancel_pressed")

# set functions
func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    dungeon_menu.set_dungeon_menu(_player)
    update_dungeon()

func enable_itilebuttons():
    for row in cols.get_children():
        for t in row.get_children():
            t.enable_itilebutton()

func disable_itilebuttons():
    for row in cols.get_children():
        for t in row.get_children():
            t.disable_itilebutton()

func enable_dungeon_menu(itile):
    dungeon_menu.enable(itile)
    disable_itilebuttons()
    emit_signal("dungeon_menu_enabled")

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
    unselect_itile()
    enable_itilebuttons()

func mark_reply_monsters(reply_state):
    var poss = reply_state.get_monsters_poss()
    for pos in poss:
        get_itile(pos).set_highlight()

# signals callbacks
func on_mouse_entered_summon(summon):
    emit_signal("mouse_entered_summon", summon)

func on_mouse_exited_tile():
    emit_signal("mouse_exited_tile")

func on_monster_pressed(itile):
    if itile.tile.content in player.monsters:
        enable_dungeon_menu(itile)

func on_reachable_path_pressed(itile):
    var pos1 = dungeon_menu.selected_itile.tile.pos
    var pos2 = itile.tile.pos
    emit_signal("move_input", pos1, pos2)
    # force enter tile
    itile._on_TileButton_mouse_entered()

func on_target_pressed(itile):
    if itile.tile.content.is_target():
        if not itile.tile.content in player.targets:
            var pos1 = dungeon_menu.selected_itile.tile.pos
            var pos2 = itile.tile.pos
            emit_signal("attack_input", pos1, pos2)

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
    dungeon_menu.disable()
    enable_itilebuttons()
    emit_signal("dungeon_menu_canceled")

# private
func unselect_itile():
    # modifications in selected itile
    if selected_itile:
        selected_itile.unset_selectmod()
        selected_itile = null
    for row in cols.get_children():
        for itile in row.get_children():
            itile.unset_all_mods()

func get_itile(pos):
    if player.id == 1:
        return cols.get_child(cols.get_child_count()-pos.y-1).get_child(pos.x)
    else: # player.id == 2
        return cols.get_child(pos.y).get_child(pos.x)
