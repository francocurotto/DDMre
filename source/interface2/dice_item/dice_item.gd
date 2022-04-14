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
        $HBoxContainer/Attack/AttackIcon.texture = load("res://art/icons/CREST_ATTACK.png")
        $HBoxContainer/Defense/DefenseIcon.texture = load("res://art/icons/CREST_DEFENSE.png")
        $HBoxContainer/Health/HealthIcon.texture = load("res://art/icons/HEALTH.png")
    else: # is item
        $HBoxContainer/Attack/AttackValue.text = ""
        $HBoxContainer/Defense/DefenseValue.text = ""
        $HBoxContainer/Health/HealthValue.text = ""
        $HBoxContainer/Attack/AttackIcon.texture = null
        $HBoxContainer/Defense/DefenseIcon.texture = null
        $HBoxContainer/Health/HealthIcon.texture = null
    for i in dice.sides.size():
        $HBoxContainer/Sides.get_child(i).set_side(dice.sides[i])

func set_diceidx(_diceidx):
    diceidx = _diceidx
    var Dicelib = load("res://engine/dice/dicelib.gd")
    var dicelib = Dicelib.new()
    var dice = dicelib.dict[diceidx]
    set_dice(dice)

func set_index(i):
    $HBoxContainer/Index.text = str(i+1) + "."
