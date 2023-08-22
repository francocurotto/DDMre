extends Sprite2D

# variables
var speed = 20
var target

func _ready():
    target = global_position

func _process(delta):
    if global_position.distance_to(target) > 1:
        global_position = global_position.lerp(target, delta*speed)
    else:
        global_position = target

# public functions
func scale_to_size(size):
    scale = size / get_rect().size
