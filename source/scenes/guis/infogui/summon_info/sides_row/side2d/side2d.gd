extends AspectRatioContainer

#region public functions
func set_side(side, type):
	$Icon.texture = load("res://assets/CREST_%s.svg" % side.crest)
	$Mult.text = str(side.mult)
	$Background.color = Globals.SUMMON_COLORS[type]
	# adjust mult location
	if side.crest == "SUMMON":
		$Mult.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		$Mult.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	else:
		$Mult.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		$Mult.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
#endregion
