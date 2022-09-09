extends GridContainer

# export variables
export(PackedScene) var SideItem

# variables
var player

# set functions 
func set_player(_player):
    player = _player

func set_dice(dice):
    clear_grid()
    add_attribute("NAME:", dice.card.name)
    add_attribute("TYPE:", dice.card.type)
    add_attribute("LEVEL:", str(dice.card.level))
    if dice.card.is_monster():
        add_attribute("ATTACK:", str(dice.card.attack))
        add_attribute("DEFENSE:", str(dice.card.defense))
        add_attribute("HEALTH:", str(dice.card.health))
    add_sides(dice.sides)

func set_dungobj(dungobj):
    clear_grid()
    if not dungobj.is_summon():
        return
    add_attribute("NAME:", dungobj.card.name)
    add_attribute("TYPE:", dungobj.card.type)
    add_attribute("LEVEL:", str(dungobj.card.level))
    if dungobj.is_monster():
        add_attribute("ATTACK:", str(dungobj.card.attack)+"/"+str(dungobj.attack))
        add_attribute("DEFENSE:", str(dungobj.card.defense)+"/"+str(dungobj.defense))
        add_attribute("HEALTH:", str(dungobj.card.health)+"/"+str(dungobj.health))

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
