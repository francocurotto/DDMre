extends AspectRatioContainer

# variables
var dungeon
var player
var selected_tile = null

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

func on_monster_pressed(tilenode):
    # case player monster pressed
    if tilenode.tile.content in player.monsters:
        # case monster selected
        if not selected_tile:
            select_tile(tilenode)
        # case monster unselected
        elif tilenode == selected_tile:
            unselect_tile()

func on_reachable_path_pressed(tilenode):
        # case trying to move
        if selected_tile:
            var pos1 = get_pos(selected_tile)
            var pos2 = get_pos(tilenode)
            emit_signal("move_input", pos1, pos2)
            unselect_tile()

# private
func select_tile(tilenode):
    selected_tile = tilenode
    selected_tile.set_selectmod()

func unselect_tile():
    if selected_tile:
        selected_tile.unset_selectmod()
        selected_tile = null

func get_pos(tile):
    for i in range(cols.get_child_count()):
        var irow = cols.get_child(i)
        for j in range(irow.get_child_count()):
            var itile = irow.get_child(j)
            if itile == tile:
                if player.id == 1: i = cols.get_child_count()-1-i # v-flip dungeon for player1
                return [i, j]
