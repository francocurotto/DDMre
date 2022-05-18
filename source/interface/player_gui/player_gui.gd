tool
extends PanelContainer

export (bool) var random_pool setget set_random_pool
export (int, 1, 2) var playerid = 1 setget set_playerid
export (String, "default", "test") var layout = "default" setget set_layout

#signal make_roll(indeces)

func _ready():
    #$PDBox/PIBBox/IBBox/PlayerInfo.hide_roll()
    #$PDBox/PIBBox/IBBox/OpponentInfo.hide_roll()
    $PDIBox/InfoBox/PInfoBox/OpponentInfo.set_opponent_title()
    # warning-ignore:return_value_discarded
    #$PDIBox/PROBox/Dicepool.connect("roll_changed", self, "on_roll_changed")
    if Engine.editor_hint:
        var Engine = load("engine/engine.gd")
        var engine = Engine.new("res://dungeons/" + layout + ".json")
        set_duel(engine.player1, engine.player2, engine.dungeon)

func set_duel(player, opponent, dungeon):
    set_player_opponent(player, opponent)
    set_dungeon(dungeon, player.id)

#func set_last_roll(sides):
#    $PDBox/PIBBox/IBBox/PlayerInfo.set_last_roll(sides)
    
func set_player_opponent(player, opponent):
    $PDIBox/PROBox/Dicepool.set_dicepool(player.dicepool)
    $PDIBox/InfoBox/PInfoBox/PlayerInfo.set_player(player)
    $PDIBox/InfoBox/PInfoBox/OpponentInfo.set_player(opponent)

func set_dungeon(dungeon, _playerid):
    $PDIBox/Dungeon.set_dungeon(dungeon, _playerid)

#func on_roll_changed():
#    $PDBox/PIBBox/IBBox/ButtonBox/RollButton.disabled = not $PDBox/PIBBox/Dicepool.roll_ready()

#func _on_RollButton_pressed():
#    var indeces = $PDBox/PIBBox/Dicepool.get_indeces()
#    emit_signal("make_roll", indeces)

func set_random_pool(_bool):
    $PDIBox/PROBox/Dicepool.set_random_pool(_bool)
    
func set_playerid(_playerid):
    playerid = _playerid
    set_duel_tool(playerid, layout)

func set_layout(_layout):
    layout = _layout
    set_duel_tool(playerid, layout)

func set_duel_tool(_playerid, _layout):
    var Engine = load("engine/engine.gd")
    var engine = Engine.new("res://dungeons/" + _layout + ".json")
    if _playerid == 1:
        set_duel(engine.player1, engine.player2, engine.dungeon)
    elif _playerid == 2:
        set_duel(engine.player2, engine.player1, engine.dungeon)
