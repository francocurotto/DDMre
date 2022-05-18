tool
extends PanelContainer

#export (bool) var roll_dice setget set_random_roll
export (int, 1, 2) var playerid = 1 setget set_playerid

func set_player(player):
    $InfoBox/CHBox/Hearts.set_player_hearts(player.id, player.monsterlord.hearts)
    $InfoBox/CHBox/CrestPool.set_pool(player.crestpool.slots)

#func set_last_roll(sides):
#    $InfoBox/CRHBox/RHBox/RBox/LastRoll.set_roll(sides)
#    $InfoBox/CRHBox/RHBox/RBox/LastRoll.visible = true

func set_opponent_title():
    $InfoBox/Title.text = "Opponent"

#func hide_roll():
#    $InfoBox/CRHBox/HBox/RBox/LastRoll.visible = false

#func update_roll(sides, engine_player):
#    $InfoBox/CRHBox/RHBox/RBox/LastRoll.set_roll(sides)
#    $InfoBox/CRHBox/RHBox/RBox/LastRoll.visible = true
#    $InfoBox/CRHBox/CrestPool.set_pool(engine_player.crestpool.slots)

#func set_random_roll(_bool):
#    $InfoBox/CRHBox/RHBox/RBox/LastRoll.set_random_roll(_bool)

func set_playerid(_playerid):
    playerid = _playerid
    $InfoBox/CHBox/Hearts.set_player_hearts(playerid, 3)
