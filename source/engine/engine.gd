extends Reference

const Dicelib = preload("res://engine/dice/dicelib.gd")
const Player = preload("res://engine/player/player.gd")
const Dungeon = preload("res://engine/dungeon/dungeon.gd")
const RollState = preload("res://engine/states/roll_state.gd")

var dicelib
var player1
var player2
var dungeon
var state

func _init(layout:=Globals.DUNGPATH, pool1:=Globals.POOL1PATH, pool2:=Globals.POOL2PATH):
    dicelib = Dicelib.new()
    player1 = Player.new(1, dicelib.create_dicepool(pool1))
    player2 = Player.new(2, dicelib.create_dicepool(pool2))
    dungeon = Dungeon.new(self, layout)
    state = RollState.new(player1, player2)

func update(cmd):
    """
    Update engine with given command.
    """
    state = state.update(cmd)

