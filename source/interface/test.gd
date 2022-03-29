extends Control

const Engine = preload("res://engine/engine.gd")

func _init():
    var engine = Engine.new()
    var dice = engine.dicelib[1]
