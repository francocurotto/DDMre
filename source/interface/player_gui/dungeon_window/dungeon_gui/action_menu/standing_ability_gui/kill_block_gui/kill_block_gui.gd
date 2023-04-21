extends VBoxContainer

# variables
var ability
var cost
var crest
var pos

# onready variables
onready var select_button = $Margins/Buttons/SelectButton
onready var cast_button = $Margins/Buttons/CastButton

# signals
signal cast_button_pressed(ability_dict)
signal cancel_button_pressed
signal ability_select_tile(tiles)

# public functions
func activate(monster):
    ability = monster.get_ability("KILLBLOCK")
    cost = ability.cost
    crest = ability.crest
    cast_button.text = "✨CAST (%d%s)" % [cost, Globals.CRESTICONS[crest]]
    cast_button.disabled = true
    select_button.pressed = false
    visible = true

func _on_SelectButton_toggled(button_pressed):
    if button_pressed:
        emit_signal("ability_select_tile", ability.get_select_tiles())
    else:
        cast_button.disabled = true

func _on_CastButton_pressed():
    visible = false
    emit_signal("cast_button_pressed", {"name":"KILLBLOCK", "pos":pos})

func _on_CancelButton_pressed():
    visible = false
    emit_signal("cancel_button_pressed")

func on_select_tile_cancel_button_pressed():
    select_button.pressed = false

func on_select_tile_select_button_pressed(tile):
    pos = tile.pos
    select_button.pressed = true
    cast_button.disabled = cost > ability.monster.player.crestpool.slots[crest]
