extends VBoxContainer

# variables
var ability
var cost
var crest
var pos

# onready variables
onready var select_button = $Margins/Buttons/SelectButton
onready var summon_info = $Margins/Buttons/SummonInfo
onready var cast_button = $Margins/Buttons/CastButton

# signals
signal highlight_ability_tiles(tiles)
signal cast_button_pressed(ability_dict)
signal cancel_button_pressed
signal ability_select_tile(tiles)

# public functions
func activate(monster):
    ability = monster.get_ability("RANGELEVELKILL")
    cost = ability.cost
    crest = ability.crest
    cast_button.text = "✨CAST"
    emit_signal("highlight_ability_tiles", ability.get_tiles_in_range(ability.tile_range))
    cast_button.disabled = true
    select_button.pressed = false
    summon_info.visible = false
    visible = true

func _on_SelectButton_toggled(button_pressed):
    if button_pressed:
        emit_signal("ability_select_tile", ability.get_select_tiles())
    else:
        cast_button.text = "✨CAST"
        cast_button.disabled = true
        summon_info.visible = false

func _on_CastButton_pressed():
    visible = false
    emit_signal("cast_button_pressed", {"name":"RANGELEVELKILL", "pos":pos})

func _on_CancelButton_pressed():
    visible = false
    emit_signal("cancel_button_pressed")

func on_select_tile_cancel_button_pressed():
    cast_button.text = "✨CAST"
    select_button.pressed = false
    summon_info.visible = false

func on_select_tile_select_button_pressed(tile):
    pos = tile.pos
    var summon = ability.dungeon.get_tile(pos).content
    var total_cost = cost + summon.card.level
    select_button.pressed = true
    summon_info.set_summon(tile.content, tile.content.player)
    cast_button.text = "✨CAST (%d%s)" % [total_cost, Globals.CRESTICONS[crest]]
    cast_button.disabled = total_cost > ability.monster.player.crestpool.slots[crest]
    summon_info.visible = true
