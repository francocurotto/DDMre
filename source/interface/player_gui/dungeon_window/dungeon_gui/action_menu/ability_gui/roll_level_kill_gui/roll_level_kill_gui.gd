extends VBoxContainer

# constants
var directions = [Vector2(0,1), Vector2(-1,0), Vector2(0,-1), Vector2(1,0)]

# variables
var ability
var cost
var crest
var level setget , get_level
var direction
var total_cost setget , get_total_cost

# onready variables
onready var level_buttongroup = $Margins/Buttons/LevelGUI/LevelButtons/ButtonLevel1.group
onready var direction_button = $Margins/Buttons/DirectionButton
onready var cast_button = $Margins/Buttons/CastButton

# signals
signal highlight_ability_tiles(tiles)
signal cast_button_pressed(ability_dict)
signal cancel_button_pressed
signal ability_select_direction(ability)

func _ready():
    level_buttongroup.connect("pressed", self, "on_level_button_pressed")

# setget functions
func get_level():
    return level_buttongroup.get_pressed_button().get_index() + 1

func get_total_cost():
    return cost + self.level

# public functions
func activate(monster):
    ability = monster.get_ability("ROLLLEVELKILL")
    cost = ability.cost
    crest = ability.crest
    direction = Vector2(0,1)
    direction_button.text = "SELECT DIRECTION " + get_direction_string()
    cast_button.text = "✨CAST (%d%s)" % [self.total_cost, Globals.CRESTICONS[crest]]
    emit_signal("highlight_ability_tiles", ability.get_roll_tiles(direction))
    cast_button.disabled = self.total_cost > ability.monster.player.crestpool.slots[crest]
    visible = true

func _on_DirectionButton_pressed():
    emit_signal("ability_select_direction", ability)

func _on_CastButton_pressed():
    visible = false
    emit_signal("cast_button_pressed", {"name":"ROLLLEVELKILL", "level":self.level, "direction":self.direction})

func _on_CancelButton_pressed():
    visible = false
    emit_signal("cancel_button_pressed")

func on_level_button_pressed(_button):
    cast_button.text = "✨CAST (%d%s)" % [self.total_cost, Globals.CRESTICONS[crest]]
    cast_button.disabled = self.total_cost > ability.monster.player.crestpool.slots[crest]

func on_select_direction_select_button_pressed(_direction):
     direction = _direction
     direction_button.text = "SELECT DIRECTION " + get_direction_string()

# private functions
func get_direction_string():
    var dirkey = direction
    if ability.monster.player.id == 2:
        dirkey = dirkey.reflect(Vector2(1,0))
    var dirdict = {Vector2(0,1)  : "⬆",
                   Vector2(-1,0) : "⬅",
                   Vector2(0,-1) : "⬇",
                   Vector2(1,0)  : "➡"}
    return dirdict[dirkey]
