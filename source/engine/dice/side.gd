extends RefCounted
## Side of a dice.
##
## A side consists in a crest and a multiplier. If the crest is of type SUMMON
## the multiplier represents the dice level.

# preloads
const SUMMON_CREST   = preload("res://engine/dice/crests/summon_crest.gd")
const MOVEMENT_CREST = preload("res://engine/dice/crests/movement_crest.gd")
const ATTACK_CREST   = preload("res://engine/dice/crests/attack_crest.gd")
const DEFENSE_CREST  = preload("res://engine/dice/crests/defense_crest.gd")
const MAGIC_CREST    = preload("res://engine/dice/crests/magic_crest.gd")
const TRAP_CREST     = preload("res://engine/dice/crests/trap_crest.gd")

# constants
## Dictionary relating a character to the crest class. Used to create a crest
## object from a character in the dice database.
const CRESTDICT = {"S" : SUMMON_CREST,
                   "M" : MOVEMENT_CREST,
                   "A" : ATTACK_CREST,
                   "D" : DEFENSE_CREST,
                   "G" : MAGIC_CREST,
                   "T" : TRAP_CREST}

# variables
var crest ## Crest of the side
var mult  ## Multiplier of the side

func _init(side_string, level):
    # create crest
    crest = CRESTDICT[side_string[0]].new()
    
    # get mult depending of the type
    if side_string[0] == "S": # if summon crest, mult equals level
        mult = level
    elif len(side_string) > 1: # else mult is second char 
        mult = int(side_string[1])
    else: # if no char, mult is 1
        mult = 1

# public functions
## Check if side with same parameters exists inside [param array].
func in_array(array):
    for side in array:
        if self.is_equal(side):
            return true
    return false
    
# private functions
## check if side has the same parameters as other side.
func is_equal(side):
    return crest.TYPE == side.crest.TYPE and mult == side.mult
    
