extends "dim_auto_ability.gd"
## EXODIA ability.
##
## Win the duel for player if all other exodia monsters are summoned in the 
## dungeon and belong to the player.

#region public functions
## Activate ability. Win the game if all exodia pieces are present.
func activate():
    # flags to check exodia pieces presence
    var r_leg = false
    var l_leg = false
    var r_arm = false
    var l_arm = false

    # iterate through all player monster searching for exodia pieces
    for monster in summon.player.monsters:
        match monster.card.name:
            "R Leg of Forbidden" : r_leg = true
            "L Leg of Forbidden" : l_leg = true
            "R Arm of Forbidden" : r_arm = true
            "L Arm of Forbidden" : l_arm = true

    # if all exodia pieces present, emit signal to win the game
    if r_leg and l_leg and r_arm and l_arm:
        Events.emit_signal("player_lost", summon.player.opponent)
#endregion
