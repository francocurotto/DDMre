extends HBoxContainer

# onready variables
@onready var CRESTDICT = {
    "MOVEMENT" : $MovementInfo,
    "ATTACK"   : $AttackInfo,
    "DEFENSE"  : $DefenseInfo,
    "MAGIC"    : $MagicInfo,
    "TRAP"     : $TrapInfo}

# public functions
func setup(crestpool):
    $MovementInfo.crest_count = crestpool.movement
    $AttackInfo.crest_count   = crestpool.attack
    $DefenseInfo.crest_count  = crestpool.defense
    $MagicInfo.crest_count    = crestpool.magic
    $TrapInfo.crest_count     = crestpool.trap

# signals callbacks
func flash(tween, roll_dice_guis, alpha):
    for roll_dice_gui in roll_dice_guis:
        var crest_type = roll_dice_gui.roll_sides.rolled_side.crest.TYPE
        if crest_type != "SUMMON":
            var crest_slot = CRESTDICT[crest_type]
            crest_slot.flash(tween, alpha)
