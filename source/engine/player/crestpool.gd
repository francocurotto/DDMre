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
func add_rolled_side(side):
    """
    Add rolled side to crest pool.
    """
    add_crests(side.crest.NAME, side.mult)
    
func add_crests(crest, amount):
    """
    Add amount number of crests of type crest from dicepool, e.g. due to
     dice roll or an ability.
    """
    # if rolled a summon, skip
    if crest == "SUMMON":
        return
    var update = slots[crest] + amount
    # check for limit surppased
    if update > LIMIT:
        emit_signal("hit_crest_limit", crest)
    # update crest pool
    slots[crest] = min(update, LIMIT)

func remove_crests(crest, amount):
    """
    Remove amount number of crests of type crest from dicepool, e.g. due to
    an ability.
    """
    slots[crest] = max(slots[crest]-amount, 0)
