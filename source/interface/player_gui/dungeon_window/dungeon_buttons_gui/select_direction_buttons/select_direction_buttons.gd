extends HBoxContainer

# constants
const directions = [Vector2(0,1), Vector2(-1,0), Vector2(0,-1), Vector2(1, 0)]

# variables
var ability

# onready variables
onready var direction_buttongroup = $UpButton.group

# signals
signal highlight_ability_tiles(tiles)
signal select_direction_select_button_pressed

func _ready():
    direction_buttongroup.connect("pressed", self, "on_direction_button_pressed")

# public functions
func initialize(_ability):
    ability = _ability
    
# signals callbacks
func _on_SelectButton_pressed():
    var direction = get_direction()
    direction_buttongroup.get_pressed_button().set_pressed_no_signal(false)
    $UpButton.set_pressed_no_signal(true)
    emit_signal("select_direction_select_button_pressed", direction)

func on_direction_button_pressed(_button):
    emit_signal("highlight_ability_tiles", ability.get_roll_tiles(get_direction()))

# private function
func get_direction():
    var index = direction_buttongroup.get_pressed_button().get_index()
    var direction = directions[index]
    # correct for player perspective
    if ability.monster.player.id == 2:
        direction = direction.reflect(Vector2(1,0))
    return direction