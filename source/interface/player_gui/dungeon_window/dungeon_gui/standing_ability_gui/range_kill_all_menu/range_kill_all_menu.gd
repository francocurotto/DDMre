extends PanelContainer

# variables
var cost
var crest

# onready variables
onready var cast_button = $VBox/Margins/Buttons/CastButton

# signals
signal cast_button_pressed(ability_dict)
signal cancel_button_pressed

# public functions
func set_menu(monster):
    var ability = monster.get_ability("RANGEKILLALL")
    cost = ability.cost
    crest = ability.crest
    cast_button.text = "✨CAST (%d%s)" % [cost, Globals.CRESTICONS[crest]]
    cast_button.disabled = cost > monster.player.crestpool.slots[crest]
    visible = true

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))

func _on_CastButton_pressed():
    visible = false
    emit_signal("cast_button_pressed", {"name":"RANGEKILLALL"})

func _on_CancelButton_pressed():
    visible = false
    emit_signal("cancel_button_pressed")
