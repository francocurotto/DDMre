extends VBoxContainer

# preloads
const RaiseAttackButton = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/attack_gui/raise_attack_gui/raise_attack_button/raise_attack_button.tscn")

# signals
signal attack_ability_activated(ability_dict)

# setget functions
func set_raise_attack_interface(monster):
    for button in get_children():
        button.queue_free()
    var ability = monster.get_ability("RAISEATTACK")
    var max_raise = ability.max_raise
    for raise in range(1, max_raise+1):
        var button = RaiseAttackButton.instance()
        button.connect("raise_attack_button_pressed", self, "on_raise_attack_button_pressed")
        button.set_raise_attack_button(raise)
        add_child(button)
        if monster.player.crestpool.slots["ATTACK"] < raise+1:
            button.disabled = true
        visible = true

# signals callbacks
func on_raise_attack_button_pressed(raise):
    emit_signal("attack_ability_activated", {"name":"RAISEATTACK", "raise":raise})
