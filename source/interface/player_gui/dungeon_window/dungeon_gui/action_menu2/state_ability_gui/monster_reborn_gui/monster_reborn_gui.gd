extends VBoxContainer

# constants
const DiceGui = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/state_ability_gui/monster_reborn_gui/dice_gui.tscn")

# variables
var ability
var monster
var dice_gui_list = []
var buttongroup = ButtonGroup.new()

# signals
signal button_pressed

func _ready():
    var dicelist = ability.get_select_dice(monster)
    for i in range(len(dicelist)):
        var dice_gui = dice_gui_list[i]
        var dice = dicelist[i]
        dice_gui.get_node("Container/Button").group = buttongroup
        add_child(dice_gui)
        dice_gui.set_dice(dice)
    buttongroup.connect("pressed", self, "on_button_pressed")

# public functions
func setup(ability_gui, _ability, _monster):
    ability = _ability
    monster = _monster
    for dice in ability.get_select_dice(monster):
        var dice_gui = DiceGui.instance()
        dice_gui_list.append(dice_gui)
        dice_gui.connect("dice_gui_info_button_pressed", ability_gui, "on_dice_gui_info_button_pressed")
    connect("button_pressed", ability_gui, "ability_castable")
    ability_gui.ability_castable(false) # disabled cast button    
    return self

func get_ability_dict():
    var selected_dice_gui
    for dice_gui in get_children():
        if dice_gui.button.pressed:
            selected_dice_gui = dice_gui
            break
    return {"dice_index" : monster.player.dicepool.find(selected_dice_gui.dice)}

# signals callbacks
func on_button_pressed(_button):
    emit_signal("button_pressed", true)
