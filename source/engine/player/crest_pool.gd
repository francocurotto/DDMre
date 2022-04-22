extends Reference

const LIMIT = 99

signal hit_crest_limit(crestname)

var slots = {
	"MOVEMENT" : 0,
	"ATTACK"   : 0,
	"DEFENSE"  : 0,
	"MAGIC"    : 0,
	"TRAP"     : 0}

func add_crests(side):
	"""
	Add rolled crests to crest pool.
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
