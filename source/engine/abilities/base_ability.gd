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
    Events.connect("next_turn", self, "on_next_turn")
    summon_activate()

func negate():
    negate_count += 1
    if negate_count == 1:
        Events.disconnect("card_summoned", self, "on_new_summon")
        Events.disconnect("next_turn", self, "on_next_turn")
        deactivate()

func remove_negate():
    negate_count -= 1
    if negate_count == 0:
        Events.connect("card_summoned", self, "on_new_summon")
        Events.connect("next_turn", self, "on_next_turn")
        summon_activate()

func activate(_ability_dict):
    pass

func summon_activate():
    pass

func item_activate(_monster):
    pass

func on_new_summon(_summon):
    pass

func on_next_turn(_player, _turn):
    pass

func deactivate():
    pass

# is functions
func is_negated():
    return negate_count > 0
