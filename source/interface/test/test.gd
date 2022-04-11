tool

extends Control

const Engine = preload("res://engine/engine.gd")

var engine

func _init():
    randomize()
    engine = Engine.new()
    
func _ready():
    #$DicelibScroll.fill(engine.dicelib)
    $VBox/Dicepool.fill(engine.player1.dicepool)

func _on_RollButton_pressed():
    if $VBox/Dicepool.rollready():
        var indeces = $VBox/Dicepool.get_indeces()
        engine.state.update({"name" : "ROLL", "dice" : indeces})
