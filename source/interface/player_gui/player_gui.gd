tool
extends PanelContainer

const Engine = preload("res://engine/engine.gd")

export (bool) var random_pool setget set_random_pool
export (int, 1, 2) var player = 1 setget set_player
export (String, "default", "test") var layout = "default" setget set_dungeon

var engine

func _ready():
    randomize()
    engine = Engine.new()
    $PDBox/PIBBox/Dicepool.set_dicepool(engine.state.player.dicepool)
    $PDBox/PIBBox/IBBox/OpponentInfo.set_opponent_title()
    $PDBox/PIBBox/IBBox/PlayerInfo.hide_roll()
    $PDBox/PIBBox/IBBox/OpponentInfo.hide_roll()
    $PDBox/Dungeon.set_tiles(engine.dungeon)
    engine.state.connect("dice_rolled", self, "on_dice_rolled")
# warning-ignore:return_value_discarded
    $PDBox/PIBBox/Dicepool.connect("roll_changed", self, "on_roll_changed")

func set_random_pool(_bool):
    $PDBox/PIBBox/Dicepool.set_random_pool(_bool)

func set_player(_player):
    player = _player
    var opponent = player%2 + 1
    $PDBox/PIBBox/IBBox/PlayerInfo.set_player(player)
    $PDBox/PIBBox/IBBox/OpponentInfo.set_player(opponent)

func set_dungeon(_layout):
    layout = _layout
    $PDBox/Dungeon.set_dungeon_standalone(layout, player)

func on_roll_changed():
    $PDBox/PIBBox/IBBox/ButtonBox/RollButton.disabled = not $PDBox/PIBBox/Dicepool.roll_ready()

func _on_RollButton_pressed():
    var indeces = $PDBox/PIBBox/Dicepool.get_indeces()
    engine.state.update({"name" : "ROLL", "dice" : indeces})

func on_dice_rolled(sides, engine_player):
    if engine_player.id == player:
        $PDBox/PIBBox/IBBox/PlayerInfo.update_roll(sides, engine_player)
    else:
        $PDBox/PIBBox/IBBox/OpponentInfo.update_roll(sides, engine_player)
