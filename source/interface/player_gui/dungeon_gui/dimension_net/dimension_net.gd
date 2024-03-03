@tool
extends Control

@export_enum("X1", "X2", "T1", "T2", "Z1", "Z2", "M1", "M2", "S1", "S2", "L1")
var net : String = "X1" :
    set(_net):
        net = _net
        display_net(NETDICT[net]) 

@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM")
var summon_type : String = "DRAGON" :
    set(_summon_type):
        summon_type = _summon_type
        $SummonIcon.texture = load("res://assets/icons/SUMMON_%s.svg" % summon_type)

# constants
const FREQ = 0.3
const NETDICT = {
    "X1" : [4, 6, 7,  8, 10, 13], 
    "X2" : [4, 6, 7, 10, 11, 13],
    "T1" : [3, 4, 5,  7, 10, 13],
    "T2" : [3, 4, 7,  8, 10, 13],
    "Z1" : [3, 4, 7, 10, 13, 14],
    "Z2" : [3, 4, 7, 10, 11, 13],
    "M1" : [3, 4, 7, 10, 11, 14],
    "M2" : [3, 6, 7, 10 ,11, 14],
    "S1" : [3, 6, 7,  8, 10, 13],
    "S2" : [3, 6, 7, 10, 11, 13],
    "L1" : [1, 4, 7,  8, 11, 14]
}

# variable
var time = 0

func _process(delta):
        time += delta
        var alpha = abs(sin(2*PI*FREQ*time))/2 + 0.1
        %Grid.modulate = Color(1,1,1,alpha)

# private functions
func display_net(net_indeces):
    for i in %Grid.get_child_count():
        %Grid.get_child(i).display = i in net_indeces
