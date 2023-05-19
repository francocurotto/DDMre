extends Reference

# variables
var max_attacks = 1
var counter = 0

# public functions
func can_attack():
    """
    Check if monster can attack given the attack cooldown.
    """
    return counter < max_attacks

func increase():
    """
    Increase cooldown counter, usually after an attack.
    """
    counter += 1

func reset():
    """
    Reset cooldown, usually after turn ends.
    """
    counter = 0

