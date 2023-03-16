extends MarginContainer

# variables
var active_gui

# onready variables
onready var reply_select_monster_buttons = $ReplySelectMonsterButtons

func _ready():
    reply_select_monster_buttons.connect("reply_ability_select_monster_cancel_button_pressed", self, "on_reply_ability_select_monster_cancel_button_pressed")
    reply_select_monster_buttons.connect("reply_ability_select_monster_select_button_pressed", self, "on_reply_ability_select_monster_select_button_pressed")

# public functions
func switch_to_reply_select_monster_buttons(monsters):
    hide_buttons_guis()
    reply_select_monster_buttons.initialize(monsters)
    active_gui = reply_select_monster_buttons

# signals callbacks
func on_tile_select_button_toggled(content, pressed):
    active_gui.on_tile_select_button_toggled(content, pressed)

func on_reply_ability_select_monster_cancel_button_pressed():
    emit_signal("reply_ability_select_monster_cancel_button_pressed")

func on_reply_ability_select_monster_select_button_pressed():
    emit_signal("reply_ability_select_monster_select_button_pressed")

# private functions
func hide_buttons_guis():
    for buttons_gui in get_children():
        buttons_gui.visible = false
