extends VBoxContainer

# constants
const DiceGui = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/state_ability_gui/monster_reborn_gui/dice_gui.tscn")

# variables
var ability
var monster
var dice_gui_list
var buttongroup = ButtonGroup.new()

func _ready():
    for dice_gui in dice_gui_list:
        dice_gui.get_node("Container/Button").group = buttongroup
        add_child(dice_gui)

# public functions
func setup(ability_gui, _ability, _monster):
    ability = _ability
    monster = _monster
    for dice in ability.get_select_dice(monster):
        var dice_gui = DiceGui.instance()
        dice_gui.set_dice(dice)
        #dice_gui.connect("info_button_pressed", ability_gui, "on_info_button_pressed")
        dice_gui_list.append(dice_gui)
    return self

func get_ability_dict():
    return {"dice" : buttongroup.get_pressed_button().index}
