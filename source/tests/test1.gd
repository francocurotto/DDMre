extends Node

# preloads
const Engine = preload("res://tests/test2.gd")
const Init = preload("res://interface/game_mode/init.gd")

# variables
var engine
#var player_gui setget , get_player_gui
#var opponent_gui setget , get_opponent_gui

# onready variables
#onready var p1gui = $P1GUI
#onready var p2gui = $P2GUI

func _ready():
    randomize()
    if Init.RANDOMPOOL:
        engine = Engine.new(Init.DUNGPATH, true)
    else:
        print(Init.DUNGPATH)
        print(Init.POOL1PATH)
        print(Init.POOL2PATH)
        #engine = Engine.new(Init.DUNGPATH, false, Init.POOL1PATH, Init.POOL2PATH)
        engine = Engine.new(Init.DUNGPATH, false, "res://databases/dicepools/ability_tests/dim_kill_tunnel.json", Init.POOL2PATH)
