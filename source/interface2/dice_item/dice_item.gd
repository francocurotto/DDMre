tool
extends MarginContainer

export (int, 1, 124) var diceidx = 89 setget set_diceidx

func set_dice(dice):
    $HBoxContainer/Name.text =  dice.card.name
    $HBoxContainer/TLA/Type.texture = load("res://art/icons/TYPE_" + dice.card.type + ".png")
    $HBoxContainer/TLA/Level.text = str(dice.level)
    if dice.card.ability.empty():
        $HBoxContainer/TLA/Ability.texture = null
    else:
        $HBoxContainer/TLA/Ability.texture = load("res://art/icons/ABILITY.png")
    if dice.card.is_monster():
        $HBoxContainer/Attack/AttackValue.text = str(dice.card.attack)
        $HBoxContainer/Defense/DefenseValue.text = str(dice.card.defense)
        $HBoxContainer/Health/HealthValue.text = str(dice.card.health)
    else: # is item
        $HBoxContainer/Attack.set_visible(false)
        $HBoxContainer/Defense.set_visible(false)
        $HBoxContainer/Health.set_visible(false)
    for i in dice.sides.size():
        $HBoxContainer/Sides.get_child(i).set_side(dice.sides[i])

func set_diceidx(_diceidx):
    diceidx = _diceidx
    var Dicelib = load("res://engine/dice/dicelib.gd")
    var dicelib = Dicelib.new()
    var dice = dicelib.dict[diceidx]
    set_dice(dice)
