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
    movement_info.set_slot_value(crestpool.slots["MOVEMENT"])
    attack_info  .set_slot_value(crestpool.slots["ATTACK"])
    defense_info .set_slot_value(crestpool.slots["DEFENSE"])
    magic_info   .set_slot_value(crestpool.slots["MAGIC"])
    trap_info    .set_slot_value(crestpool.slots["TRAP"])
