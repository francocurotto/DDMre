extends HBoxContainer

# variables
var crestpool

# onready variables
onready var movement = $Movement
onready var attack = $Attack
onready var defense = $Defense
onready var magic = $Magic
onready var trap = $Trap

# setget functions
func set_crestpool(_crestpool):
    crestpool = _crestpool
    update_crestpool()

# public functions
func update_crestpool():
    movement.set_slot_value(crestpool.slots["MOVEMENT"])
    attack  .set_slot_value(crestpool.slots["ATTACK"  ])
    defense .set_slot_value(crestpool.slots["DEFENSE" ])
    magic   .set_slot_value(crestpool.slots["MAGIC"   ])
    trap    .set_slot_value(crestpool.slots["TRAP"    ])
