extends VBoxContainer

# preloads
const RaiseAttackButton = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/attack_gui/raise_attack_gui/raise_attack_button/raise_attack_button.gd")

# signals
signal attack_ability_activated(ability_dict)

# setget functions
func setup(attack_gui, monster):
    var ability = monster.get_ability("RAISEATTACK")
    var max_raise = ability.max_raise
    for raise in range(1, max_raise+1):
        var button = RaiseAttackButton.instance().setup(self, monster, raise)
        add_child(button)
    connect("attack_ability_activated", attack_gui, "on_attack_ability_activated")
    return self

# signals callbacks
func on_raise_attack_button_pressed(raise):
    emit_signal("attack_ability_activated", {"name":"RAISEATTACK", "raise":raise})
