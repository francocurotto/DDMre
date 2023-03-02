extends HBoxContainer

# variables
var player
var cost = 0
var crest = "DEFENSE"
var amount = 0

# onready variables
onready var label = $Label
onready var up_button = $Buttons/UpButton
onready var down_button = $Buttons/DownButton

# signals
signal ability_cost_changed(cost, crest)

# setget functions
func set_reply_interface(monster):
    player = monster.player
    update_interface()

func get_ability_dict():
    if cost>0:
        return {"name":"REDUCEDAMAGEINF", "reduce":cost}
    else:
        return null

# signals callbacks
func _on_UpButton_pressed():
    cost += 1
    update_interface()
    emit_signal("ability_cost_changed", cost, crest)

func _on_DownButton_pressed():
    cost -= 1
    update_interface()
    emit_signal("ability_cost_changed", cost, crest)

# private functions
func update_interface():
    label.text = "✨REDUCE DAMAGE -%d (%d%s)" % [cost*10, cost, Globals.CRESTICONS[crest]]
    up_button.disabled = cost >= player.crestpool.slots[crest]
    down_button.disabled = cost <= 0
