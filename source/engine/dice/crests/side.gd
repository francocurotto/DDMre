extends Reference

const SummonCrest = preload("res://engine/dice/crests/summon_crest.gd")
const MovementCrest = preload("res://engine/dice/crests/movement_crest.gd")
const AttackCrest = preload("res://engine/dice/crests/attack_crest.gd")
const DefenseCrest = preload("res://engine/dice/crests/defense_crest.gd")
const MagicCrest = preload("res://engine/dice/crests/magic_crest.gd")
const TrapCrest = preload("res://engine/dice/crests/trap_crest.gd")

const CRESTDICT = {"S" : SummonCrest,
				   "M" : MovementCrest,
				   "A" : AttackCrest,
				   "D" : DefenseCrest,
				   "G" : MagicCrest,
				   "T" : TrapCrest}
var crest
var mult

func _init(sidestring):
	crest = CRESTDICT[sidestring[0]].new()
	#TODO: support >9 mults
	mult = int(sidestring[1]) if len(sidestring)>1 else 1
