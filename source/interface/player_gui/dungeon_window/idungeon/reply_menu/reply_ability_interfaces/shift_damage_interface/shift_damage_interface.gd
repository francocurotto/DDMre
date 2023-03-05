extends VBoxContainer

# variables
var cost
var crest
var monster

# onready variables
onready var button = $Button
onready var summon_info = $SummonInfo

# signals
signal activate_tile_ability_buttons(dungobjs)

# setget functions
func set_reply_interface(interface):
    monster = interface.attacked
    connect("activate_tile_ability_buttons", interface, "on_activate_tile_ability_buttons")
    var ability = monster.get_ability("SHIFTDAMAGE")
    cost = ability.cost
    crest = ability.crest
    button.text = "✨SHIFT DAMAGE (%d%s)" % [cost, Globals.CRESTICONS[crest]] 
    button.disabled = cost > monster.player.crestpool.slots[crest]

func get_ability_dict():
    if button.pressed:
        return {"name":"SHIFTDAMAGE"}
    else:
        return null

# signals callbacks
func _on_Button_toggled(button_pressed):
    if button_pressed:
        var other_monsters = monster.get_player_other_monsters()
        emit_signal("activate_tile_ability_buttons", other_monsters)
