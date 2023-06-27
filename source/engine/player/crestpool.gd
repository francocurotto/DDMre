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

# set functions
func set_crest(crest, amount):
    """
    Set an amount number of crests of type crest to crestpool. It clips the 
    values if the amount goes off limits.
    """
    # check lower limit of zero
    amount = max(0, amount)
    # check for upper limit
    amount = min(LIMIT, amount)
    # update crest pool
    slots[crest] = amount

# public functions
func add_rolled_side(side):
    """
    Add rolled side to crest pool. If rolled side is summon, skip the addition.
    """
    if side.crest.NAME != "SUMMON":
        add_crests(side.crest.NAME, side.mult)
    
func add_crests(crest, amount):
    """
    Add amount number of crests of type crest to crestpool.
    """
    set_crest(crest, slots[crest]+amount)

func remove_crests(crest, amount):
    """
    Remove amount number of crests of type crest from dicepool.
    """
    set_crest(crest, slots[crest]-amount)
