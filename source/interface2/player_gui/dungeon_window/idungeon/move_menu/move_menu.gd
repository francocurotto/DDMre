extends PanelContainer

# variables
var pos1
var pos2
var format = "[center]Spend %d [img=25]art/icons/CREST_MOVEMENT.png[/img] crests (left: %d[img=25]art/icons/CREST_MOVEMENT.png[/img])[/center]"

# onready variables
onready var message = $VBox/Message

# singals
signal menu_move_button_pressed
signal menu_canceled

# public functions
func activate(_pos1, _pos2, path, player):
    pos1 = _pos1
    pos2 = _pos2
    var spend = len(path)-1
    var left = player.crestpool.slots["MOVEMENT"] - spend
    message.bbcode_text = format % [spend, left]
    visible = true

# signals callbacks
func _on_MenuMoveButton_pressed():
    visible = false
    emit_signal("menu_move_button_pressed", pos1, pos2)

func _on_MenuCancelButton_pressed():
    visible = false
    emit_signal("menu_canceled")
