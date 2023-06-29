extends HBoxContainer

# variables
var crestpool

# onready variables
onready var movement_info = $MovementInfo
onready var attack_info = $AttackInfo
onready var defense_info = $DefenseInfo
onready var magic_info = $MagicInfo
onready var trap_info = $TrapInfo

func _ready():
    Events.connect("duel_update", self, "update_crestpool")

# setget functions
func set_crestpool(_crestpool):
    crestpool = _crestpool
    update_crestpool()

# signals callbacks
func update_crestpool():
    movement_info.set_slot_value(crestpool.movement)
    attack_info  .set_slot_value(crestpool.attack)
    defense_info .set_slot_value(crestpool.defense)
    magic_info   .set_slot_value(crestpool.magic)
    trap_info    .set_slot_value(crestpool.trap)
