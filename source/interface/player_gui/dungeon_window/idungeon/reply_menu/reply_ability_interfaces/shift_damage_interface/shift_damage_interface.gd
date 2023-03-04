extends VBoxContainer

# variables
var cost
var crest

# onready variables
onready var button = $Button
onready var summon_info = $SummonInfo

# signals
signal ability_cost_changed(cost, crest)

# setget functions
func set_reply_interface(interface):
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
    summon_info.visible = button_pressed
