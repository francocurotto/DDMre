extends HBoxContainer

# public functions
func setup(crestpool):
    $MovementInfo.crest_count = crestpool.movement
    $AttackInfo.crest_count   = crestpool.attack
    $DefenseInfo.crest_count  = crestpool.defense
    $MagicInfo.crest_count    = crestpool.magic
    $TrapInfo.crest_count     = crestpool.trap
