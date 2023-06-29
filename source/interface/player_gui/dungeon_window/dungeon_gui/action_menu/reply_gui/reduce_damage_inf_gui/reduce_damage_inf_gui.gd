extends HBoxContainer

# variables
var ability
var cost = 0
var crest = "DEFENSE"

# onready variables
onready var label = $Label
onready var up_button = $Buttons/UpButton
onready var down_button = $Buttons/DownButton

# signals
signal ability_cost_changed(cost, crest)

# public functions
func setup(reply_gui, _ability):
    ability = _ability
    connect("ability_cost_changed", reply_gui, "on_ability_cost_changed")
    return self

func get_ability_dict():
    if cost>0:
        return {"name":"REDUCEDAMAGEINF", "reduce":cost}

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
    up_button.disabled = cost >= ability.monster.player.crestpool.get_crest(crest)
    down_button.disabled = cost <= 0
