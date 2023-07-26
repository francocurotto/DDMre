extends Reference

# preloads
const SummonCrest = preload("res://engine/dice/crests/summon_crest.gd")
const MovementCrest = preload("res://engine/dice/crests/movement_crest.gd")
const AttackCrest = preload("res://engine/dice/crests/attack_crest.gd")
const DefenseCrest = preload("res://engine/dice/crests/defense_crest.gd")
const MagicCrest = preload("res://engine/dice/crests/magic_crest.gd")
const TrapCrest = preload("res://engine/dice/crests/trap_crest.gd")

# constants
const CRESTDICT = {"S" : SummonCrest,
                   "M" : MovementCrest,
                   "A" : AttackCrest,
                   "D" : DefenseCrest,
                   "G" : MagicCrest,
                   "T" : TrapCrest}

# variables
var crest
var mult

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
