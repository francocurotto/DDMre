extends VBoxContainer

# constants
const SelectTileGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_tile_gui/select_tile_gui.tscn")

# variables
var select_tile_gui

# onready variables
onready var summon_info = $SummonInfo

func _ready():
    select_tile_gui.connect("toggled", self, "on_button_toggled")
    add_child(select_tile_gui)
    move_child(select_tile_gui, 0)

# public functions
func setup(standing_ability_gui, ability):
    select_tile_gui = SelectTileGUI.instance().setup(standing_ability_gui, ability)
    return self

func get_ability_dict():
    return select_tile_gui.get_ability_dict()

func change_button_name(name):
    select_tile_gui.text = name

# signals callbacks
func on_button_toggled(button_pressed):
    if not button_pressed:
        summon_info.visible = false

func on_select_tile_cancel_button_pressed():
    select_tile_gui.on_select_tile_cancel_button_pressed()
    summon_info.visible = false

func on_select_tile_select_button_pressed(tile):
    select_tile_gui.on_select_tile_select_button_pressed(tile)
    summon_info.set_summon(tile.content, tile.content.player)
    summon_info.visible = true
