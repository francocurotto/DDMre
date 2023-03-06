extends VBoxContainer

# variables
var cost
var crest

# onready variables
onready var button = $Button
onready var summon_info = $SummonInfo

# signals
signal shiftdamage_button_pressed

# setget functions
func set_reply_interface(interface):
    connect("shiftdamage_button_pressed", interface, "on_shiftdamage_button_pressed")
    var ability = interface.attacked.get_ability("SHIFTDAMAGE")
    cost = ability.cost
    crest = ability.crest
    button.text = "✨SHIFT DAMAGE (%d%s)" % [cost, Globals.CRESTICONS[crest]] 
    button.disabled = cost > interface.attacked.player.crestpool.slots[crest]

func get_ability_dict():
    if button.pressed:
        return {"name":"SHIFTDAMAGE"}
    else:
        return null

# signals callbacks
func _on_Button_toggled(button_pressed):
    if button_pressed:
        emit_signal("shiftdamage_button_pressed")

func on_cancel_reply_ability_button_pressed():
    button.pressed = false
    summon_info.visible = false
