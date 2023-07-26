extends HBoxContainer

# constants
const directions = [Vector2(0,1), Vector2(1,0), Vector2(0,-1), Vector2(-1, 0)]

# variables
var ability
var index
var direction setget , get_direction 

# signals
signal highlight_ability_tiles(tiles)
signal select_direction_select_button_pressed

# setget functions
func get_direction():
    return directions[index%len(directions)]

# public functions
func initialize(_ability, _direction):
    ability = _ability
    index = directions.find(_direction)

# signals callbacks
func _on_SelectButton_pressed():
    emit_signal("select_direction_select_button_pressed", self.direction)

func _on_ClockWiseButton_pressed():
    if ability.summon.player.id == 1:
        index += 1
    elif ability.summon.player.id == 2:
        index -= 1
    emit_signal("highlight_ability_tiles", ability.get_roll_tiles(self.direction))

func _on_CounterClockWiseButton_pressed():
    if ability.summon.player.id == 1:
        index -= 1
    elif ability.summon.player.id == 2:
        index += 1
    emit_signal("highlight_ability_tiles", ability.get_roll_tiles(self.direction))
