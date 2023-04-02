extends PanelContainer

# variables
var cost
var crest

# onready variables
onready var cast_button = $VBox/Margins/Buttons/CastButton

# signals
signal cast_button_pressed(ability_dict)
signal cancel_button_pressed
signal check_dungeon_button_pressed

# public functions
func set_menu(monster):
    var ability = monster.get_ability("RANGEKILLALL")
    cost = ability.cost
    crest = ability.crest
    cast_button.text = "✨CAST (%d%s)" % [cost, Globals.CRESTICONS[crest]]
    cast_button.disabled = cost > monster.player.crestpool.slots[crest]
    visible = true

func _on_CheckDungeonButton_pressed():
    emit_signal("check_dungeon_button_pressed")

func _on_CastButton_pressed():
    visible = false
    emit_signal("cast_button_pressed", {"name":"RANGEKILLALL"})

func _on_CancelButton_pressed():
    visible = false
    emit_signal("cancel_button_pressed")
