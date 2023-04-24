extends VBoxContainer

# variables
var cost
var amount

# onready variables
onready var cast_button = $Margins/Buttons/CastButton

# signals
signal cast_button_pressed(ability_dict)
signal skip_button_pressed

# public functions
func activate(monster):
    var ability = monster.get_ability("DIMTRADECREST")
    cost = ability.cost
    amount = ability.amount
    #cast_button.text = "✨CAST (%d%s)" % [cost, Globals.CRESTICONS[crest]]
    #cast_button.disabled = cost > monster.player.crestpool.slots[crest]
    cast_button.disabled = true
    visible = true

func _on_CastButton_pressed():
    emit_signal("cast_button_pressed", {"name":"DIMKILLTUNNELALL"})
    visible = false

func _on_SkipButton_pressed():
    emit_signal("skip_button_pressed")
    visible = false
