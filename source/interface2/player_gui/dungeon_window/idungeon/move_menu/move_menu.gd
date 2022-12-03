extends PanelContainer

# variables
var format = "[center]Spend %d [img=25]art/icons/CREST_MOVEMENT.png[/img] crests (left: %d[img=25]art/icons/CREST_MOVEMENT.png[/img])[/center]"

# onready variables
onready var message = $VBox/Message

func activate(path, player):
    var spend = len(path)-1
    var left = player.crestpool.slots["MOVEMENT"] - spend
    message.bbcode_text = format % [spend, left]
    visible = true
