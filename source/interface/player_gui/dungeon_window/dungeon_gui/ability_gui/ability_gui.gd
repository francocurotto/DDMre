extends MarginContainer

# variables
var ability_menus_dict

# onready variables
onready var buff_self_menu = $BuffSelfMenu

func _ready():
    ability_menus_dict = {"BUFFSELF" : buff_self_menu}

# public functions
func activate_menu(monster):
    for ability in monster.card.abilities:
        if ability.name in ability_menus_dict:
            var active_menu = ability_menus_dict[ability.name]
            active_menu.set_menu(monster)
            active_menu.visible = true
            visible = true
