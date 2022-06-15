tool
extends PanelContainer

export (bool) var random_pool setget set_random_pool
export (int, 1, 2) var playerid = 1 setget set_playerid
export (String, "default", "test") var layout = "test" setget set_layout

var engine
var player
var opponent

func _ready():
    $PDIBox/InfoBox/PInfoBox/OpponentInfo.set_opponent_title()
    $PDIBox/PROBox/RollGUI.hide_rolls()
    # connections
    # warning-ignore:return_value_discarded
    $PDIBox/PROBox/Dicepool.connect("roll_changed", self, "on_roll_changed")
    # warning-ignore:return_value_discarded
    $PDIBox/PROBox/RollGUI.connect("roll_pressed", self, "on_roll_pressed")
    # warning-ignore:return_value_discarded
    $PDIBox/PROBox/Dicepool.connect("mouse_entered_dice", 
        $PDIBox/InfoBox/ItemInfo, "on_mouse_entered_dice")
    # warning-ignore:return_value_discarded
    $PDIBox/PROBox/Dicepool.connect("mouse_exited_dice", 
        $PDIBox/InfoBox/ItemInfo, "on_mouse_exited_dice")
    # warning-ignore:return_value_discarded
    $PDIBox/Dungeon.connect("mouse_entered_dungobj", 
        $PDIBox/InfoBox/ItemInfo, "on_mouse_entered_dungobj")
    # warning-ignore:return_value_discarded
    $PDIBox/Dungeon.connect("mouse_exited_dungobj", 
        $PDIBox/InfoBox/ItemInfo, "on_mouse_exited_dungobj")
    if Engine.editor_hint:
        var Engine = load("engine/engine.gd")
        # warning-ignore:shadowed_variable
        var engine = Engine.new("res://dungeons/" + layout + ".json")
        set_duel(engine, engine.player1, engine.player2)

func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    $PDIBox/PROBox/Dicepool.set_dicepool(player.dicepool)
    $PDIBox/InfoBox/PInfoBox/PlayerInfo.set_player(player)
    $PDIBox/InfoBox/PInfoBox/OpponentInfo.set_player(opponent)
    $PDIBox/Dungeon.set_dungeon(engine.dungeon, player)
    $PDIBox/InfoBox/ItemInfo.set_player(player)
    # engine connection
    engine.messager.connect("engine_message", $PDIBox/PROBox/TextOutput,
        "on_engine_message")

func set_player_roll(sides):
    $PDIBox/PROBox/RollGUI.update_roll_player(sides)

func set_opponent_roll(sides):
    $PDIBox/PROBox/RollGUI.update_roll_opponent(sides)

func on_roll_changed():
    $PDIBox/PROBox/RollGUI.set_roll_button($PDIBox/PROBox/Dicepool.roll_ready())

func on_roll_pressed():
    var indeces = $PDIBox/PROBox/Dicepool.get_indeces()
    engine.state.update({"name" : "ROLL", "dice" : indeces})

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
# warning-ignore:shadowed_variable
    var engine = Engine.new("res://dungeons/" + _layout + ".json")
    if _playerid == 1:
        set_duel(engine, engine.player1, engine.player2)
    elif _playerid == 2:
        set_duel(engine, engine.player2, engine.player1)
