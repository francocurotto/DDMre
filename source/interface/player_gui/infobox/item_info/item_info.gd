extends GridContainer

# export variables
export(PackedScene) var SideItem

# variables
var player

# set functions 
func set_player(_player):
    player = _player

func set_dice(idx):
    var dice = player.dicepool[idx]
    clear_grid()
    add_attribute("NAME:", dice.card.name)
    add_attribute("TYPE:", dice.card.type)
    add_attribute("LEVEL:", str(dice.card.level))
    if dice.card.is_monster():
        add_attribute("ATTACK:", str(dice.card.attack))
        add_attribute("DEFENSE:", str(dice.card.defense))
        add_attribute("HEALTH:", str(dice.card.health))
    add_sides(dice.sides)

func set_summon(summon):
    clear_grid()
    # case opponent item
    if summon.is_item() and not summon in player.items:
        add_attribute("NAME:", "???")
        add_attribute("TYPE:", summon.card.type)
        add_attribute("LEVEL:", str(summon.card.level))
    # case player summon or opponent monster
    else:
        add_attribute("NAME:", summon.card.name)
        add_attribute("TYPE:", summon.card.type)
        add_attribute("LEVEL:", str(summon.card.level))
        if summon.is_monster():
            add_attribute("ATTACK:", str(summon.attack)+"/"+str(summon.card.attack))
            add_attribute("DEFENSE:", str(summon.defense)+"/"+str(summon.card.defense))
            add_attribute("HEALTH:", str(summon.health)+"/"+str(summon.card.health))

func clear_grid():
    for child in get_children():
        remove_child(child)
        child.queue_free()

# private functions
func add_attribute(str1, str2):
    var label1 = Label.new()
    var label2 = Label.new()
    label1.text = str1
    label2.text = str2
    add_child(label1)
    add_child(label2)

func add_sides(sides):
    var label = Label.new()
    label.text = "DICE:"
    var sidesbox = HBoxContainer.new()
    for side in sides:
        var sideitem = SideItem.instance()
        sideitem.set_side(side)
        sidesbox.add_child(sideitem)
    add_child(label)
    add_child(sidesbox)
