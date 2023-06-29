extends Reference

# constants
const LIMIT = 99

# variables
var movement = 0
var attack   = 0
var defense  = 0
var magic    = 0
var trap     = 0

# setget functions
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
    set(crest.to_lower(), amount)

func get_crest(crest):
    """
    Get crest value by name. Convert to lowercase.
    """
    return get(crest.to_lower())

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
    set_crest(crest, get_crest(crest)+amount)

func remove_crests(crest, amount):
    """
    Remove amount number of crests of type crest from dicepool.
    """
    set_crest(crest, get_crest(crest)-amount)

func remove_movement(amount):
    """
    Helper function to remove movement crests quickly.
    """
    remove_crests("movement", amount)
    
func remove_attack(amount):
    """
    Helper function to remove attack crests quickly.
    """
    remove_crests("attack", amount)

func remove_defense(amount):
    """
    Helper function to remove defense crests quickly.
    """
    remove_crests("defense", amount)
