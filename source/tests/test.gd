extends Node

func _ready():
    var l = [8]
    fill_list(l)
    print(l)
    var dict = {[0,1]:"a"}
    print(dict[[0,1]])

func fill_list(ll):
    for i in ll:
        if len(ll) > 10:
            break
        ll.append(ll[-1]+1)
