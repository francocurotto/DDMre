extends MarginContainer

# variables
var pos
var ability_menus_dict
var active_menu

# onready variables
onready var buff_self_menu = $BuffSelfMenu
onready var buff_damage_menu = $BuffDamageMenu
onready var distance_attack_menu = $DistanceAttackMenu

# signals
signal ability_cmd(cmd)
signal standing_ability_cast_button_pressed
signal standing_ability_cancel_button_pressed

func _ready():
    ability_menus_dict = {"BUFFSELF"       : buff_self_menu,
                          "BUFFDAMAGE"     : buff_damage_menu,
                          "DISTANCEATTACK" : distance_attack_menu}

# public functions
func activate_menu(tile):
    pos = tile.pos
    for ability in tile.content.card.abilities:
        if ability.name in ability_menus_dict:
            active_menu = ability_menus_dict[ability.name]
            active_menu.set_menu(tile.content)
            active_menu.connect("cast_button_pressed", self, "on_cast_button_pressed")
            active_menu.connect("cancel_button_pressed", self, "on_cancel_button_pressed")
            visible = true

# signals callbacks
func on_cast_button_pressed(ability_dict):
    visible = false
    active_menu.disconnect("cast_button_pressed", self, "on_cast_button_pressed")
    active_menu.disconnect("cancel_button_pressed", self, "on_cancel_button_pressed")
    emit_signal("ability_cmd", {"name":"ABILITY", "pos":pos, "ability":ability_dict})

func on_cancel_button_pressed():
    visible = false
    active_menu.disconnect("cast_button_pressed", self, "on_cast_button_pressed")
    active_menu.disconnect("cancel_button_pressed", self, "on_cancel_button_pressed")
    emit_signal("standing_ability_cancel_button_pressed")
