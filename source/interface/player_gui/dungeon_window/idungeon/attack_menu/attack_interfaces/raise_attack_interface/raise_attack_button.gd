extends Button

# variables
var crests

# setget functions
func set_raise_attack_button(attack, _crests):
    crests = _crests
    text = "⚔ATTACK %d (%d⚔)" % [attack+10*crests, crests+1] 
