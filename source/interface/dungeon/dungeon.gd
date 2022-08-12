extends AspectRatioContainer

# variables
var dungeon
var player

# onready variables
onready var cols = $Cols

# signals
signal mouse_entered_dungobj(dungobj)
signal mouse_exited_dungobj(dungobj)

func _ready():
    for row in cols.get_children():
        for t in row.get_children():
            t.connect("mouse_entered_dungobj", self, "on_mouse_entered_dungobj")
            t.connect("mouse_exited_dungobj", self, "on_mouse_exited_dungobj")

# set functions
func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    update_dungeon()

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
