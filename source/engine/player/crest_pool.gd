extends Reference

# constants
const LIMIT = 99

# variables
var slots = {
    "MOVEMENT" : 0,
    "ATTACK"   : 0,
    "DEFENSE"  : 0,
    "MAGIC"    : 0,
    "TRAP"     : 0}

# signals
signal hit_crest_limit(crestname)

# public functions
func add_crests(side):
    """
    Add rolled side to crest pool.
    """
    # if rolled a summon, skip
    if side.crest.NAME == "SUMMON":
        return
    var update = slots[side.crest.NAME] + side.mult
    # check for limit surppased
    if update > LIMIT:
        emit_signal("hit_crest_limit", side.crest.NAME)
    # update crest pool
    slots[side.crest.NAME] = min(update, LIMIT)
