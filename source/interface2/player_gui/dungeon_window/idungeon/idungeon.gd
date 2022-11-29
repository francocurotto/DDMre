extends AspectRatioContainer

# variables
var dungeon
var player
var selected_itile
var itiles

# onready variables
onready var rows = $Rows

# signals
signal tile_select_button_toggled(itile, pressed)
signal tile_dim_button_pressed(itile)

func _ready():
    itiles = get_tree().get_nodes_in_group("itiles")
    for itile in itiles:
        itile.connect("tile_select_button_toggled", self, "on_tile_select_button_toggled")
        itile.connect("tile_dim_button_pressed", self, "on_tile_dim_button_pressed")

# setget functions
func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    for i in range(rows.get_child_count()):
        var irow = get_irow(i)
        var row = dungeon.array[i]
        for j in range(irow.get_child_count()):
            var itile = irow.get_child(j)
            var tile = row[j]
            itile.set_tile(tile)

# public functions
func enable_select_buttons():
    for itile in itiles:
        itile.enable_select_button()

func disable_all_buttons():
    for itile in itiles:
        itile.disable_all_buttons()

func reset():
    disable_all_buttons()
    enable_select_buttons()
    if selected_itile:
        selected_itile._on_TileSelectButton_toggled(false) # deselect itile

# signals callbacks
func on_tile_select_button_toggled(itile, pressed):
    assign_selected_itile(itile, pressed)
    release_unselected_itiles()
    emit_signal("tile_select_button_toggled", itile.tile.content, pressed)

func on_tile_dim_button_pressed(itile):
    on_tile_select_button_toggled(itile, true)
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

func on_dice_dim_button_pressed(dicecol):
    disable_all_buttons()
    for itile in itiles:
        itile.enable_dim_button()

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
