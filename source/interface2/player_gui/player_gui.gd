tool
extends PanelContainer

const Engine = preload("res://engine/engine.gd")

export (bool) var random_pool setget set_random_pool
export (int, 1, 2) var player = 1 setget set_player

var engine

func _ready():
	engine = Engine.new()
	engine.state.connect("dice_rolled", $PIBBox/IBBox/PlayerInfo, "on_dice_rolled")
	$PIBBox/Dicepool.set_dicepool(engine.state.player.dicepool)
	$PIBBox/IBBox/OpponentInfo.set_opponent_title()
	$PIBBox/IBBox/PlayerInfo.hide_roll()
	$PIBBox/IBBox/OpponentInfo.hide_roll()
	$PIBBox/Dicepool.connect("roll_changed", self, "on_roll_changed")

func set_random_pool(_bool):
	$PIBBox/Dicepool.set_random_pool(_bool)

func set_player(_player):
	player = _player
	var opponent = player%2 + 1
	$PIBBox/IBBox/PlayerInfo.set_player(player)
	$PIBBox/IBBox/OpponentInfo.set_player(opponent)

func on_roll_changed():
	$PIBBox/IBBox/ButtonBox/RollButton.disabled = not $PIBBox/Dicepool.roll_ready()

func _on_RollButton_pressed():
	var indeces = $PIBBox/Dicepool.get_indeces()
	engine.state.update({"name" : "ROLL", "dice" : indeces})
