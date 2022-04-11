extends TextureRect

func update_item(side):
	"""
	Update the side graphics with information of new side.
	"""
	texture = load("res://art/icons/CREST_" + side.crest.NAME + ".png")
	$Mult.text = str(side.mult)
	if side.crest.is_summon():
		$Mult.text = ""
