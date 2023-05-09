extends VBoxContainer

# constants
var directions = [Vector2(0,1), Vector2(-1,0), Vector2(0,-1), Vector2(1,0)]

# variables
var ability
var direction
var level setget , get_level
var total_cost setget , get_total_cost

# onready variables
onready var level_buttongroup = $Controls/LevelGUI/LevelButtons/ButtonLevel1.group
onready var direction_button = $Controls/DirectionButton

# signals
signal highlight_ability_tiles(tiles)
signal ability_cost_changed(cost)
signal select_direction_pressed

func _ready():
    if ability.monster.player.id == 1:
        direction = Vector2(0,1)
    else:
        direction = Vector2(0,-1)
    set_direction_button_text()
    level_buttongroup.connect("pressed", self, "on_level_button_pressed")
    emit_signal("highlight_ability_tiles", ability.get_roll_tiles(direction))
    emit_signal("ability_cost_changed", self.total_cost)

# setget functions
func get_level():
    return level_buttongroup.get_pressed_button().get_index() + 1

func get_total_cost():
    return ability.cost + self.level

# public functions
func setup(ability_gui, _ability):
    ability = _ability
    connect("highlight_ability_tiles", ability_gui, "on_highlight_ability_tiles")
    connect("select_direction_pressed", ability_gui, "on_select_direction_pressed")
    connect("ability_cost_changed", ability_gui, "on_ability_cost_changed")
    return self

func get_ability_dict():
    return {"level":self.level, "direction":self.direction}

# signals callbacks
func _on_DirectionButton_pressed():
    emit_signal("select_direction_pressed")

func on_level_button_pressed(_button):
    emit_signal("ability_cost_changed", self.total_cost)

func on_select_direction_select_button_pressed(_direction):
     direction = _direction
     set_direction_button_text()

# private functions
func set_direction_button_text():
    var dirkey = direction
    if ability.monster.player.id == 2:
        dirkey = dirkey.reflect(Vector2(1,0))
    var dirdict = {Vector2(0,1)  : "⬆",
                   Vector2(-1,0) : "⬅",
                   Vector2(0,-1) : "⬇",
                   Vector2(1,0)  : "➡"}
    direction_button.text = "SELECT DIRECTION " + dirdict[dirkey]
