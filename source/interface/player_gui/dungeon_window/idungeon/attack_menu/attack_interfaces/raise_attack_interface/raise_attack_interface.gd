extends VBoxContainer

# preloads
const RaiseAttackButton = preload("res://interface/player_gui/dungeon_window/idungeon/attack_menu/attack_interfaces/raise_attack_interface/raise_attack_button.tscn")

# setget functions
func set_raise_attack_interface(monster):
    var ability = monster.get_ability("RAISEATTACK")
    var max_raise = ability.max_raise
    for i in range(max_raise):
        var button = RaiseAttackButton.instance()
        button.set_raise_attack_button(monster.attack, i+1)
        add_child(button)
