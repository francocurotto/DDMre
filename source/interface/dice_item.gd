extends MarginContainer

func update_item(dice):
	# create dice strings
	var indexstr = "000".substr(len(str(dice.id))) + str(dice.id) + "."
	var tlastr = dice.card.type[0] +  str(dice.level)
	var attackstr = ""
	var defensestr = "" 
	var healthstr = ""
	if dice.card.is_monster():
		attackstr = "[right]" + str(dice.card.attack) + "A" + "[/right]"
		defensestr = "[right]" + str(dice.card.defense) + "A" + "[/right]"
		healthstr = "[right]" + str(dice.card.health) + "A" + "[/right]"
	var sidesstr = "[right]"
	for side in dice.sides:
		sidesstr += side.crest.name[0] + str(side.mult)
	sidesstr += "[/right]"

	# assign strings
	$HBox/Index.text = indexstr
	$HBox/Name.text = dice.card.name
	$HBox/TLACont/TLA.bbcode_text = tlastr
	$HBox/AttackCont/Attack.bbcode_text = attackstr
	$HBox/DefenseCont/Defense.bbcode_text = defensestr
	$HBox/HealthCont/Health.bbcode_text = healthstr
	$HBox/SidesCont/Sides.bbcode_text = sidesstr
