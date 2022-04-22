extends VBoxContainer

func set_pool(slots):
	set_slot($MovementSlot/MovementValue, slots["MOVEMENT"])
	set_slot($AttackSlot/AttackValue,     slots["ATTACK"])
	set_slot($DefenseSlot/DefenseValue,   slots["DEFENSE"])
	set_slot($MagicSlot/MagicValue,       slots["MAGIC"])
	set_slot($TrapSlot/TrapValue,         slots["TRAP"])

func set_slot(label, value):
	label.text = str(value).pad_zeros(2)
