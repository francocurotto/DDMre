extends HBoxContainer

# public functions
func setup(card):
    if card.type == "ITEM":
        modulate = Color(1,1,1,0)
    else:
        modulate = Color(1,1,1,1)
        $AttackInfo.value  = card.attack
        $DefenseInfo.value = card.defense
        $HealthInfo.value  = card.health
