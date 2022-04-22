tool
extends PanelContainer

export (bool) var roll_dice setget set_random_roll
export (int, 1, 2) var player = 1 setget set_player

func set_random_roll(_bool):
	$InfoBox/CRHBox/RHBox/RBox/LastRoll.set_random_roll(_bool)

func set_player(_player):
	player = _player
	$InfoBox/CRHBox/RHBox/HBox/Hearts.set_player(player)

func set_opponent_title():
	$InfoBox/Title.text = "Opponent Info"

func hide_roll():
	$InfoBox/CRHBox/RHBox/RBox/LastRoll.visible = false

func update_roll(sides, engine_player):
	$InfoBox/CRHBox/RHBox/RBox/LastRoll.set_roll(sides)
	$InfoBox/CRHBox/RHBox/RBox/LastRoll.visible = true
	$InfoBox/CRHBox/CrestPool.set_pool(engine_player.crestpool.slots)
