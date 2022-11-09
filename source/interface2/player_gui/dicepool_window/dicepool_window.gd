extends VBoxContainer

# onready variables
onready var dicepool_column = $DicepoolPanel/DicepoolVBox/DicepoolColumn

# signals
signal info_button_pressed(card)

func _ready():
    # signal connections
    dicepool_column.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dicepool(dicepool, dimdice):
    dicepool_column.set_dicepool(dicepool, dimdice)

# signals callbacks
func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)
