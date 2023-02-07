extends Reference

# variables
var name
var summon
var dungeon
var negate_count = 0

func _init(ability_info):
    name = ability_info["NAME"]

# public functions
func on_summon(_summon, _dungeon):
    summon = _summon
    dungeon = _dungeon
    Events.connect("card_summoned", self, "on_new_summon")
    summon_activate()

func negate():
    negate_count += 1
    if Events.is_connected("card_summoned", self, "on_new_summon"):
        Events.disconnect("card_summoned", self, "on_new_summon")
    deactivate()

func remove_negate():
    negate_count -= 1
    if negate_count <= 0:
        Events.connect("card_summoned", self, "on_new_summon")
        summon_activate()

func summon_activate():
    pass

func item_activate(_monster):
    pass

func on_new_summon(_summon):
    pass

func deactivate():
    pass

# is functions
func is_negated():
    return negate_count > 0
