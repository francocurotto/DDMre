extends VBoxContainer

# variables
var ability
var pos

# onready variables
onready var button = $Button
onready var summon_info = $SummonInfo

# signals
signal ability_select_tile
signal ability_cost_changed(cost, crest)

func _ready():
    button.disabled = ability.cost > ability.monster.player.crestpool.slots[ability.crest]

# public functions
func setup(standing_ability_gui, _ability):
    ability = _ability
    connect("ability_cost_changed", standing_ability_gui, "on_ability_cost_changed")
    connect("ability_select_tile", standing_ability_gui, "on_ability_select_tile")
    standing_ability_gui.cast_button.disabled = true
    return self

func get_ability_dict():
    if button.pressed:
        return {"name":ability.name, "pos":pos}

# signals callbacks
func _on_Button_toggled(button_pressed):
    if button_pressed:
        emit_signal("ability_select_tile", ability.get_select_tiles())
    else:
        summon_info.visible = false

func on_select_tile_cancel_button_pressed():
    button.pressed = false
    summon_info.visible = false

func on_select_tile_select_button_pressed(tile):
    pos = tile.pos
    button.pressed = true
    summon_info.set_summon(tile.content, tile.content.player)
    summon_info.visible = true
    emit_signal("ability_cost_changed", get_ability_cost(tile), ability.crest)

# private functions
func get_ability_cost(_tile):
    return ability.cost
