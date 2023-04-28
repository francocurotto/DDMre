extends VBoxContainer

# variables
var ability
var cost
var crest
var pos

# onready variables
onready var button = $Button
onready var summon_info = $SummonInfo

# signals
signal ability_cost_changed(cost, crest)
signal ability_select_tile

func _ready():
    cost = ability.cost
    crest = ability.crest
    button.text = "✨%s (%d%s)" % [ability.name, cost, Globals.CRESTICONS[crest]]
    button.disabled = cost > ability.monster.player.crestpool.slots[crest]

# public functions
func setup(reply_gui, _ability):
    ability = _ability
    connect("ability_cost_changed", reply_gui, "on_ability_cost_changed")
    connect("ability_select_tile", reply_gui, "on_ability_select_tile")
    return self

func get_ability_dict():
    if button.pressed:
        return {"name":ability.name, "pos":pos}
    else:
        return null

# signals callbacks
func _on_Button_toggled(button_pressed):
    if button_pressed:
        emit_signal("ability_cost_changed", cost, crest)
        emit_signal("ability_select_tile", ability.get_select_tiles())
    else:
        emit_signal("ability_cost_changed", 0, crest)
        summon_info.visible = false

func on_select_tile_cancel_button_pressed():
    button.pressed = false
    summon_info.visible = false

func on_select_tile_select_button_pressed(tile):
    pos = tile.pos
    button.pressed = true
    summon_info.set_summon(tile.content, tile.content.player)
    summon_info.visible = true
