extends Node

func _ready():
    var d = {"a":1}
    for k in d:
        if d[k]>10:
            break
        d[k+"a"] = d[k]+1
    print(d)
