extends VBoxContainer

# variables
var crestpool

# onready variables
onready var movement_value = $MovementSlot/MovementValue
onready var attack_value = $AttackSlot/AttackValue
onready var defense_value = $DefenseSlot/DefenseValue
onready var magic_value = $MagicSlot/MagicValue
onready var trap_value = $TrapSlot/TrapValue

# setget functions
func set_crestpool(_crestpool):
    crestpool = _crestpool
    update_slots()

func update_slots():
    set_slot(movement_value, crestpool.slots["MOVEMENT"])
    set_slot(attack_value,   crestpool.slots["ATTACK"])
    set_slot(defense_value,  crestpool.slots["DEFENSE"])
    set_slot(magic_value,    crestpool.slots["MAGIC"])
    set_slot(trap_value,     crestpool.slots["TRAP"])

func set_slot(label, value):
    label.text = str(value).pad_zeros(2)
