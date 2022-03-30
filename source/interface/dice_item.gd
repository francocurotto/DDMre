extends PanelContainer

func update_item(dice):
    var sidesstr = ""
    for side in dice.sides:
        sidesstr += side.crest.name[0] + str(side.mult)
    $HBox/Index.text = "000".substr(len(str(dice.id))) + str(dice.id) + "."
    $HBox/Name.text = dice.card.name
    $HBox/TLACont/TLA.text = dice.card.type[0] +  str(dice.level)
    if dice.card.is_monster():
        $HBox/AttackCont/Attack.text = str(dice.card.attack) + "A"
        $HBox/DefenseCont/Defense.text = str(dice.card.defense) + "D"
        $HBox/HealthCont/Health.text = str(dice.card.health) + "H"
    $HBox/SidesCont/Sides.text = sidesstr
    
    
