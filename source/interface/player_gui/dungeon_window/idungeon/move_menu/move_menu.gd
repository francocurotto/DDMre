extends PanelContainer

# variables
var pos1
var pos2
var format = "[center]Spend %d [img=25]art/icons/CREST_MOVEMENT.png[/img] crests (left: %d[img=25]art/icons/CREST_MOVEMENT.png[/img])[/center]"

# onready variables
onready var message = $VBox/Message
onready var transparent_button = $VBox/TransparentButton

# singals
signal menu_move_button_pressed
signal menu_canceled



# public functions
func activate(_pos1, _pos2, move_cost, player):
    pos1 = _pos1
    pos2 = _pos2
    var left = player.crestpool.slots["MOVEMENT"] - move_cost
    message.bbcode_text = format % [move_cost, left]
    visible = true
    transparent_button.pressed = false

# signals callbacks
func _on_MenuMoveButton_pressed():
    visible = false
    emit_signal("menu_move_button_pressed", pos1, pos2)

func _on_MenuCancelButton_pressed():
    visible = false
    emit_signal("menu_canceled")

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))
