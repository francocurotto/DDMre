tool
extends HBoxContainer

# export variables
export (int, 0, 99) var value = 0 setget set_slot_value
export (String, "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP") var slot = "MOVEMENT" setget set_slot_icon

# setget functions
func set_slot(_value, _slot):
    set_slot_value(_value)
    set_slot_icon(_slot)

func set_slot_value(_value):
    value = _value
    if has_node("Value"):
        $Value.text = str(value).pad_zeros(2)

func set_slot_icon(_slot):
    slot = _slot
    if has_node("Icon"):
        $Icon.texture = load("res://art/icons/CREST_" + slot + ".png")
