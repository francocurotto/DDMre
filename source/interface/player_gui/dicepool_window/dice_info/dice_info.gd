extends PanelContainer

# public functions
func setup(dice):
    %SummonIcon.texture = load("res://art/icons/SUMMON_%s.svg" % dice.card.type)
    %Name.text = dice.card.name
    %AttributesInfo.setup(dice.card)
    %SidesInfo.setup(dice)
    %AbilitiesInfo.setup(dice.card.abilities)
