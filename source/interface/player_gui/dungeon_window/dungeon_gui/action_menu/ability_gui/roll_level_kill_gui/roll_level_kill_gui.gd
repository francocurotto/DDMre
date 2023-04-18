extends VBoxContainer

# constants
var directions = [Vector2(0,1), Vector2(-1,0), Vector2(0,-1), Vector2(1,0)]

# variables
var ability
var cost
var crest
var level setget , get_level
var direction setget , get_direction
var total_cost setget , get_total_cost

# onready variables
onready var level_buttongroup = $Margins/Buttons/LevelGUI/LevelButtons/ButtonLevel1.group
onready var direction_buttongroup = $Margins/Buttons/DirectionGUI/DirectionButtons/ButtonDirUp.group
onready var cast_button = $Margins/Buttons/CastButton

# signals
signal highlight_ability_tiles(tiles)
signal cast_button_pressed(ability_dict)
signal cancel_button_pressed
signal ability_select_tile(tiles)

func _ready():
    level_buttongroup.connect("pressed", self, "on_level_button_pressed")

# setget functions
func get_level():
    return level_buttongroup.get_pressed_button().get_index() + 1

func get_direction():
    return directions[direction_buttongroup.get_pressed_button().get_index()]

func get_total_cost():
    return cost + self.level

# public functions
func activate(monster):
    ability = monster.get_ability("ROLLLEVELKILL")
    cost = ability.cost
    crest = ability.crest
    cast_button.text = "✨CAST (%d%s)" % [self.total_cost, Globals.CRESTICONS[crest]]
    emit_signal("highlight_ability_tiles", ability.get_roll_tiles(self.direction))
    cast_button.disabled = self.total_cost > ability.monster.player.crestpool.slots[crest]
    visible = true

#func _on_SelectButton_toggled(button_pressed):
#    if button_pressed:
#        emit_signal("ability_select_tile", ability.get_select_tiles())
#    else:
#        cast_button.text = "✨CAST"
#        cast_button.disabled = true
#        summon_info.visible = false

func _on_CastButton_pressed():
    visible = false
    emit_signal("cast_button_pressed", {"name":"ROLLLEVELKILL", "level":self.level, "direction":self.direction})

func _on_CancelButton_pressed():
    visible = false
    emit_signal("cancel_button_pressed")

func on_level_button_pressed():
    cast_button.text = "✨CAST (%d%s)" % [self.total_cost, Globals.CRESTICONS[crest]]
    cast_button.disabled = self.total_cost > ability.monster.player.crestpool.slots[crest]

#func on_select_tile_cancel_button_pressed():
#    cast_button.text = "✨CAST"
#    select_button.pressed = false
#    summon_info.visible = false
#
#func on_select_tile_select_button_pressed(tile):
#    pos = tile.pos
#    var summon = ability.dungeon.get_tile(pos).content
#    var total_cost = cost + summon.card.level
#    select_button.pressed = true
#    summon_info.set_summon(tile.content, tile.content.player)
#    cast_button.text = "✨CAST (%d%s)" % [total_cost, Globals.CRESTICONS[crest]]
#    cast_button.disabled = total_cost > ability.monster.player.crestpool.slots[crest]
#    summon_info.visible = true
