extends PanelContainer

func _ready():
    $HBox.visible = false

# public functions
func setup(dice):
    var texture = load("res://art/icons/SUMMON_%s.svg" % dice.card.type)
    $HBox.visible = true
    %SummonIcon.texture = texture
    %Name.text = dice.card.name
    %AttributesInfo.setup(dice.card)
    %SidesInfo.setup(dice)
    %AbilitiesInfo.setup(dice.card.abilities)    
