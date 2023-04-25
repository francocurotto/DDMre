extends VBoxContainer

# variables
var cost
var amount
var monster
var crests = ["MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP"]

# onready variables
onready var pay_label = $Margins/Buttons/PayGUI/PayText
onready var gain_label = $Margins/Buttons/GainGUI/GainText
onready var paycrest_buttongroup = $Margins/Buttons/PayGUI/PayButtons/MoveButton.group
onready var gaincrest_buttongroup = $Margins/Buttons/GainGUI/GainButtons/MoveButton.group
onready var cast_button = $Margins/Buttons/CastButton

# signals
signal cast_button_pressed(ability_dict)
signal skip_button_pressed

func _ready():
    paycrest_buttongroup.connect("pressed", self, "on_pay_button_pressed")
    gaincrest_buttongroup.connect("pressed", self, "on_gain_button_pressed")

# public functions
func activate(_monster):
    monster = _monster
    var ability = monster.get_ability("DIMTRADECREST")
    cost = ability.cost
    amount = ability.amount
    pay_label.text = "Pay Crest (%d)" % cost
    gain_label.text = "Gain Crest (%d)" % amount
    for i in range(len(crests)):
        var button = paycrest_buttongroup.get_child(i)
        if monster.player.crestpool.slots[crests[i]] < cost:
            button.disable = true
    cast_button.disabled = true
    visible = true

func on_pay_button_pressed():
    if gaincrest_buttongroup.get_pressed_button():
        cast_button.disable = false
    var crest = crests[paycrest_buttongroup.get_pressed_button().get_index()]
    cast_button.text = "✨CAST (%d%s)" % [cost, Globals.CRESTICONS[crest]]
    cast_button.disabled = cost > monster.player.crestpool.slots[crest]

func on_gain_button_pressed():
    if paycrest_buttongroup.get_pressed_button():
        cast_button.disable = false

func _on_CastButton_pressed():
    var pay_crest = crests[paycrest_buttongroup.get_pressed_button().get_index()]
    var gain_crest = crests[gaincrest_buttongroup.get_pressed_button().get_index()]
    emit_signal("cast_button_pressed", {"name":"DIMTRADECREST", "pay_crest":pay_crest, "gain_crest":gain_crest})
    visible = false

func _on_SkipButton_pressed():
    emit_signal("skip_button_pressed")
    visible = false
