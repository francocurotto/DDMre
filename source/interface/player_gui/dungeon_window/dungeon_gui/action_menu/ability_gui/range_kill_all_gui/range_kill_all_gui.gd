extends VBoxContainer

# variables
var cost
var crest

# onready variables
onready var cast_button = $Margins/Buttons/CastButton

# signals
signal highlight_ability_tiles(tiles)
signal cast_button_pressed(ability_dict)
signal cancel_button_pressed

# public functions
func activate(monster):
    var ability = monster.get_ability("RANGEKILLALL")
    cost = ability.cost
    crest = ability.crest
    cast_button.text = "✨CAST (%d%s)" % [cost, Globals.CRESTICONS[crest]]
    cast_button.disabled = cost > monster.player.crestpool.slots[crest]
    emit_signal("highlight_ability_tiles", ability.get_tiles_in_range())
    visible = true

func _on_CastButton_pressed():
    visible = false
    emit_signal("cast_button_pressed", {"name":"RANGEKILLALL"})

func _on_CancelButton_pressed():
    visible = false
    emit_signal("cancel_button_pressed")
