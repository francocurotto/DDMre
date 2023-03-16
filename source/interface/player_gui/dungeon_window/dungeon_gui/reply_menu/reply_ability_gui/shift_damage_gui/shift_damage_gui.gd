extends VBoxContainer

# variables
var cost
var crest
var pos

# onready variables
onready var button = $Button
onready var summon_info = $SummonInfo

# signals
signal reply_ability_select_monster

# setget functions
func set_reply_gui(attacked):
    var ability = attacked.get_ability("SHIFTDAMAGE")
    cost = ability.cost
    crest = ability.crest
    button.text = "✨SHIFT DAMAGE (%d%s)" % [cost, Globals.CRESTICONS[crest]] 
    button.disabled = cost > attacked.player.crestpool.slots[crest]
    button.set_pressed_no_signal(false)
    summon_info.visible = false

func get_ability_dict():
    if button.pressed:
        return {"name":"SHIFTDAMAGE", "pos":pos}
    else:
        return null

# signals callbacks
func _on_Button_toggled(button_pressed):
    if button_pressed:
        emit_signal("reply_ability_select_monster")
    else:
        summon_info.visible = false

func on_select_monster_cancel_button_pressed():
    button.pressed = false
    summon_info.visible = false

func on_select_monster_select_button_pressed(tile):
    pos = tile.pos
    button.pressed = true
    summon_info.set_summon(tile.content, tile.content.player)
    summon_info.visible = true
