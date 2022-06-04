tool
extends VBoxContainer

var crestpool

func set_crestpool(_crestpool):
    crestpool = _crestpool
    update_slots()

func update_slots():
    set_slot($MovementSlot/MovementValue, crestpool.slots["MOVEMENT"])
    set_slot($AttackSlot/AttackValue,     crestpool.slots["ATTACK"])
    set_slot($DefenseSlot/DefenseValue,   crestpool.slots["DEFENSE"])
    set_slot($MagicSlot/MagicValue,       crestpool.slots["MAGIC"])
    set_slot($TrapSlot/TrapValue,         crestpool.slots["TRAP"])

func set_slot(label, value):
    label.text = str(value).pad_zeros(2)
