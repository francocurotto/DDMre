extends VBoxContainer

# variables
var ability
var crests = ["MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP"]

# onready variables
onready var pay_label = $Controls/PayGUI/PayText
onready var gain_label = $Controls/GainGUI/GainText
onready var paycrest_buttongroup = $Controls/PayGUI/PayButtons/MoveButton.group
onready var gaincrest_buttongroup = $Controls/GainGUI/GainButtons/MoveButton.group

# signals
signal ability_cost_changed

func _ready():
    pay_label.text = "Pay Crest (%d)" % ability.cost
    gain_label.text = "Gain Crest (%d)" % ability.amount
    paycrest_buttongroup.connect("pressed", self, "on_pay_button_pressed")
    gaincrest_buttongroup.connect("pressed", self, "on_gain_button_pressed")

# public functions
func setup(ability_gui, _ability):
    ability = _ability
    connect("ability_cost_changed", ability_gui, "on_ability_cost_changed")
    return self

func on_pay_button_pressed(button):
    var crest = crests[button.get_index()]
    if gaincrest_buttongroup.get_pressed_button():
        emit_signal("ability_cost_changed", ability.cost, crest)

func on_gain_button_pressed(_button):
    var button = paycrest_buttongroup.get_pressed_button()
    if button:
        var crest = crests[button.get_index()]
        emit_signal("ability_cost_changed", ability.cost, crest)
