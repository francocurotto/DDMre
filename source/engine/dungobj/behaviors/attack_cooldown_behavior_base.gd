extends RefCounted
## Monster behavior on how to handle the attack cooldown.
##
## The attack cooldown behavior base has a max attack value and a counter to
## track the number of attacks a monster can perform per turn. Normally,
## monsters can only attack once per turn, hence [code]max_attack=1[/code].
## Some monster have abilities that let them attack more than once, in that 
## case [code]max_attack[/code] is set to a higher value. Also attacks can be
## disable entirely by setting [code]max_attack=0[/code].

#region variables
var max_attacks = 1 ## Maximum number of attacks a monster can perform per turn
var counter = 0 ## Variable to track the current number of attacks in turn
#endregion

#region public functions
## Increase cooldown counter, usually after an attack.
func activate():
    counter += 1

## Reset cooldown counter, usually after turn ends.
func reset():
    counter = 0
#endregion

#region is functions
## Check if monster can attack given the attack cooldown.
func can_attack():
    return counter < max_attacks
##endregion

