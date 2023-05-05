extends Button

# variables
var ability
var pos

# signals
signal ability_select_tile
signal ability_cost_changed(cost, crest)

func _ready():
    disabled = ability.cost > ability.monster.player.crestpool.slots[ability.crest]

# public functions
func setup(standing_ability_gui, _ability):
    ability = _ability
    connect("ability_cost_changed", standing_ability_gui, "on_ability_cost_changed")
    connect("ability_select_tile", standing_ability_gui, "on_ability_select_tile")
    standing_ability_gui.cast_button.disabled = true
    return self

func get_ability_dict():
    if pressed:
        return {"pos":pos}

# signals callbacks
func _on_SelectTileGUI_toggled(button_pressed):
    emit_signal("ability_select_tile", button_pressed, ability.get_select_tiles())

func on_select_tile_cancel_button_pressed():
    pressed = false

func on_select_tile_select_button_pressed(tile):
    pos = tile.pos
    pressed = true
