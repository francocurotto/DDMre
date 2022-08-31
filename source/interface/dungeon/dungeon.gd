extends AspectRatioContainer

# variables
var dungeon
var player
var selected_itile = null

# onready variables
onready var cols = $Cols

# signals
signal mouse_entered_dungobj(dungobj)
signal mouse_exited_dungobj(dungobj)
signal move_input(pos1, pos2)

func _ready():
    for row in cols.get_children():
        for t in row.get_children():
            t.connect("mouse_entered_dungobj", self, "on_mouse_entered_dungobj")
            t.connect("mouse_exited_dungobj", self, "on_mouse_exited_dungobj")
            t.connect("monster_pressed", self, "on_monster_pressed")
            t.connect("reachable_path_pressed", self, "on_reachable_path_pressed")

# set functions
func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    update_dungeon()

func enable_tilebuttons():
    for row in cols.get_children():
        for t in row.get_children():
            t.enable_button()

func disable_tilebuttons():
    for row in cols.get_children():
        for t in row.get_children():
            t.disable_button()

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

# signals callbacks
func on_mouse_entered_dungobj(dungobj):
    emit_signal("mouse_entered_dungobj", dungobj)

func on_mouse_exited_dungobj():
    emit_signal("mouse_exited_dungobj")

func on_monster_pressed(itile):
    # case player monster pressed
    if itile.tile.content in player.monsters:
        # case monster selected
        if not selected_itile:
            select_tile(itile)
        # case monster unselected
        elif itile == selected_itile:
            unselect_tile()

func on_reachable_path_pressed(itile):
        # case trying to move
        if selected_itile:
            var pos1 = selected_itile.tile.pos
            var pos2 = itile.tile.pos
            emit_signal("move_input", pos1, pos2)
            unselect_tile()

# private
func select_tile(itile):
    selected_itile = itile
    selected_itile.set_selectmod()
    var moveposs = dungeon.get_moveposs(player, itile.tile.pos)
    for movepos in moveposs:
        get_itile(movepos).set_movetile()

func unselect_tile():
    if selected_itile:
        selected_itile.unset_selectmod()
        selected_itile = null
    for row in cols.get_children():
        for itile in row.get_children():
            itile.unset_movetile() 

func get_itile(pos):
    if player.id == 1:
        return cols.get_child(cols.get_child_count()-pos.y-1).get_child(pos.x)
    else: # player.id == 2
        return cols.get_child(pos.y).get_child(pos.x)
