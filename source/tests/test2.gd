extends Reference

# preloads
const Dicelib = preload("res://engine/dice/dicelib.gd")
const Player = preload("res://engine/player/player.gd")
const Dungeon = preload("res://engine/dungeon/dungeon.gd")
const RollState = preload("res://engine/states/roll_state.gd")

# variables
var dicelib
var player1
var player2
var dungeon
var state
var turn = 1

func _init(initpath, random_pool:=true, pool1:=null, pool2:=null):
    # duel objects
    dicelib = Dicelib.new()
    if random_pool:
        player1 = Player.new(1, dicelib.create_randpool())
        player2 = Player.new(2, dicelib.create_randpool())
    else:
        print(initpath)
        print(pool1)
        print(pool2)
        player1 = Player.new(1, dicelib.create_dicepool(pool1))
        player2 = Player.new(2, dicelib.create_dicepool(pool2))
