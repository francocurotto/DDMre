extends HBoxContainer

# variables
var player
var cost
var crest = "DEFENSE"

# onready variables
onready var label = $Label
onready var up_button = $Buttons/UpButton
onready var down_button = $Buttons/DownButton

# signals
signal ability_cost_changed(cost, crest)

# setget functions
func set_reply_gui(attacked):
    player = attacked.player
    cost = 0
    update_gui()

func get_ability_dict():
    if cost>0:
        return {"name":"REDUCEDAMAGEINF", "reduce":cost}
    else:
        return null

# signals callbacks
func _on_UpButton_pressed():
    cost += 1
    update_gui()
    emit_signal("ability_cost_changed", cost, crest)

func _on_DownButton_pressed():
    cost -= 1
    update_gui()
    emit_signal("ability_cost_changed", cost, crest)

# private functions
func update_gui():
    label.text = "✨REDUCE DAMAGE -%d (%d%s)" % [cost*10, cost, Globals.CRESTICONS[crest]]
    up_button.disabled = cost >= player.crestpool.slots[crest]
    down_button.disabled = cost <= 0
