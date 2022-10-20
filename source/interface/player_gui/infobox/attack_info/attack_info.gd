extends VBoxContainer

# onready variables
onready var attacker_info = $AttackerInfo
onready var attacked_info = $AttackedInfo

# setget functions
func set_info(kwargs):
    var attacker = kwargs["attacker"]
    var attacked = kwargs["attacked"]
    attacker_info.set_info({"summon":attacker, "target":attacked})
    attacked_info.set_info({"summon":attacked})
