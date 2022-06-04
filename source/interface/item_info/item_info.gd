tool
extends PanelContainer

export(PackedScene) var SideItem
export (int, 1, 124) var diceidx = 89 setget set_diceidx

var player

func _ready():
    clear_grid()
    
func set_player(_player):
    player = _player

func set_dice(dice):
    clear_grid()
    add_text("NAME:", dice.card.name)
    add_text("TYPE:", dice.card.type)
    add_text("LEVEL:", str(dice.card.level))
    if dice.card.is_monster():
        add_text("ATTACK:", str(dice.card.attack))
        add_text("DEFENSE:", str(dice.card.defense))
        add_text("HEALTH:", str(dice.card.health))
    add_sides(dice.sides)

func clear_grid():
    for child in $InfoBox/InfoGrid.get_children():
        $InfoBox/InfoGrid.remove_child(child)
        child.queue_free()

func add_text(str1, str2):
    var label1 = Label.new()
    var label2 = Label.new()
    label1.text = str1
    label2.text = str2
    $InfoBox/InfoGrid.add_child(label1)
    $InfoBox/InfoGrid.add_child(label2)

func add_sides(sides):
    var label = Label.new()
    label.text = "DICE:"
    var sidesbox = HBoxContainer.new()
    for side in sides:
        var sideitem = SideItem.instance()
        sideitem.set_side(side)
        sidesbox.add_child(sideitem)
    $InfoBox/InfoGrid.add_child(label)
    $InfoBox/InfoGrid.add_child(sidesbox)

func on_mouse_entered_dice(idx):
    var dice = player.dicepool[idx]
    set_dice(dice)

func on_mouse_exited_dice():
    clear_grid()

func set_diceidx(_diceidx):
    diceidx = _diceidx
    var Dicelib = load("res://engine/dice/dicelib.gd")
    var dicelib = Dicelib.new()
    var dice = dicelib.create_dice(diceidx)
    set_dice(dice)
