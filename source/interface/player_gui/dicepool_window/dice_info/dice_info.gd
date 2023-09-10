extends PanelContainer

func _ready():
    $HBox.modulate = Color(1,1,1,0)
    
# public functions
func setup(dice):
    var texture = load("res://assets/icons/SUMMON_%s.svg" % dice.card.type)
    %SummonIcon.texture = texture
    %Name.text = dice.card.name
    %AttributesInfo.setup(dice.card)
    %SidesInfo.setup(dice)
    %AbilitiesInfo.setup(dice.card.abilities)
    $HBox.modulate = Color(1,1,1,1)
