extends MarginContainer

const COMMON_ABILITIES = ["FLY", "ARCHER", "TUNNELING", "NEUTRAL"]
const ICONWIDTH = "15"

func update_item(dice):
	$HBox/Index.text = "000".substr(len(str(dice.id))) + str(dice.id) + "."
	$HBox/Name.text = dice.card.name
	$HBox/TLACont/TLA.bbcode_text = get_tlastr(dice)
	$HBox/AttackCont/Attack.bbcode_text = get_attackstr(dice.card)
	$HBox/DefenseCont/Defense.bbcode_text = get_defensestr(dice.card)
	$HBox/HealthCont/Health.bbcode_text = get_healthstr(dice.card)
	$HBox/SidesCont/Sides.bbcode_text = get_sidesstr(dice.sides)
	
func get_tlastr(dice):
	var string = "[img=" + ICONWIDTH + "]"
	string += "res://art/icons/TYPE_" + dice.card.type + ".png[/img]"
	string += str(dice.level)
	if dice.card.ability:
		string += "[img=" + ICONWIDTH + "]" 
		string += "res://art/icons/ABILITY" + ".png[/img]"   
	return string

func get_attackstr(card):
	if card.is_item():
		return ""
	var string = "[right]" + str(card.attack)
	string += "[img=" + ICONWIDTH + "]"
	string  += "res://art/icons/CREST_ATTACK.png[/img][/right]"
	return string

func get_defensestr(card):
	if card.is_item():
		return ""
	var string = "[right]" + str(card.defense)
	string += "[img=" + ICONWIDTH + "]"
	string  += "res://art/icons/CREST_DEFENSE.png[/img][/right]"
	return string

func get_healthstr(card):
	if card.is_item():
		return ""
	var string = "[right]" + str(card.health)
	string += "[img=" + ICONWIDTH + "]"
	string  += "res://art/icons/HEALTH.png[/img][/right]"
	return string  

func get_sidesstr(sides):
	var sidesstr = "[right]"
	for side in sides:
		sidesstr += "[img=" + ICONWIDTH + "]"
		sidesstr +=  "res://art/icons/CREST_" + side.crest.NAME + ".png[/img]"
		sidesstr += str(side.mult)
	sidesstr += "[/right]"
	return sidesstr
