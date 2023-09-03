extends PanelContainer

# variables
var dice

# public functions
func setup(_dice):
    dice = _dice
    %Name.text = dice.card.name
    %AttributesInfo.setup(dice.card)
    %SidesInfo.setup(dice.sides)
    %AbilitiesInfo.setup(dice.card.abilities)
