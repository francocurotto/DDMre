tool
extends MarginContainer

export (int, 1, 124) var diceidx = 89 setget set_diceidx

func set_dice(dice):
    $Button/HBoxContainer/Name.text =  dice.card.name

func set_diceidx(_diceidx):
    diceidx = _diceidx
    var Dicelib = load("res://engine/dice/dicelib.gd")
    var dicelib = Dicelib.new()
    var dice = dicelib.dict[diceidx]
    set_dice(dice)
