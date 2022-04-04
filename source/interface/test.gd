extends Control

const Engine = preload("res://engine/engine.gd")

var engine

func _init():
	engine = Engine.new()
	
func _ready():
	$DicelibScroll.fill(engine.dicelib)
