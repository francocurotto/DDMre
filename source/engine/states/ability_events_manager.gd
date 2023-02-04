extends Reference

# variables
var player
var opponent
var dungeon

func _init(_player, _opponent, _dungeon):
    player = _player
    opponent = _opponent
    dungeon = _dungeon
    # signals connections
    AbilityEvents.connect("dim_buff_dead_type_activated", self, "on_dim_buff_type_activated")
    AbilityEvents.connect("exodia_activated", self, "on_exodia_activated")
    AbilityEvents.connect("gluminizer_activated", self, "on_gluminizer_activated")

# private functions
func on_dim_buff_type_activated(monster, type):
    var attack_buff = 0
    var defense_buff = 0
    var total_graveyard = player.graveyard + opponent.graveyard
    for dead_monster in total_graveyard:
        if dead_monster.NAME == type:
            attack_buff += dead_monster.card.attack
            defense_buff += dead_monster.card.defense
    monster.attack += attack_buff
    monster.defense += defense_buff

func on_exodia_activated():
    Events.emit_signal("player_lost", opponent)

func on_gluminizer_activated():
    dungeon.move_cost = 2
