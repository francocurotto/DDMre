extends RefCounted
## Pool of crests.
##
## The crest pool stores counters for all the crests acquired by a player
## during rolls and other methods. It also manages how crests are added and
## removed from the crestpool.

#region constants
const LIMIT = 99 ## Maximum number of crests for each type.
#endregion

#region variables
var movement = 0 ## Movement crest counter.
var attack   = 0 ## Attack crest counter.
var defense  = 0 ## Defense crest counter.
var magic    = 0 ## Magic crest counter.
var trap     = 0 ## Trap crest counter.
#endregion

#region public functions
## Set the crest number of type [param crest] to [param amount]. Clip the value
## if the amount if it goes off limit.
func set_crest(crest, amount):
    # clamp amount between limits
    amount = clamp(amount, 0 , LIMIT)
    # update crest pool
    set(crest.to_lower(), amount)

## Get the crest number of type [param crest].
func get_crest(crest):
    return get(crest.to_lower())

## Add the rolled [param sides] list of sides to the crest pool. If a rolled 
## side is of type SUMMON, skip the addition.
func add_rolled_sides(sides):
    for side in sides:
        if side.crest.TYPE != "SUMMON":
            add_crests(side.crest.TYPE, side.mult)
    
## Add [param amount] number of crests of type [param crest] to crest pool.
func add_crests(crest, amount):
    set_crest(crest, get_crest(crest)+amount)

## Remove [param amount] number of crests of type [param crest] to crest pool.
func remove_crests(crest, amount):
    set_crest(crest, get_crest(crest)-amount)

## Remove [param amount] number of crests of type MOVEMENT to crest pool.
func remove_movement(amount):
    remove_crests("movement", amount)
    
## Remove [param amount] number of crests of type ATTACK to crest pool.
func remove_attack(amount):
    remove_crests("attack", amount)

## Remove [param amount] number of crests of type DEFENSE to crest pool.
func remove_defense(amount):
    remove_crests("defense", amount)
#endregion
