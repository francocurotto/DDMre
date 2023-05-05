extends Button

# variables
var ability
var pos

# signals
signal select_tile_gui_toggled

func _ready():
    disabled = ability.cost > ability.monster.player.crestpool.slots[ability.crest]

# public functions
func setup(standing_ability_gui, _ability):
    ability = _ability
    connect("select_tile_gui_toggled", standing_ability_gui, "on_select_tile_gui_toggled")
    _on_SelectTileGUI_toggled(false)
    return self

func get_ability_dict():
    if pressed:
        return {"pos":pos}

# signals callbacks
func _on_SelectTileGUI_toggled(button_pressed):
    emit_signal("select_tile_gui_toggled", button_pressed)

func on_select_tile_cancel_button_pressed():
    pressed = false

func on_select_tile_select_button_pressed(tile):
    pos = tile.pos
    pressed = true
