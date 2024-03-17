extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
    print(-1%4)
    var d = {"a":1, "b":2, "c":3}
    print(d[0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass
