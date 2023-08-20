extends Sprite2D

# variables
var speed = 2000
var target

func _ready():
    target = global_position

func _process(delta):
    if global_position.distance_to(target) > 20:
        var velocity = global_position.direction_to(target) * speed
        global_position += velocity * delta
    else:
        global_position = target

# public functions
func scale_to_size(size):
    scale = size / get_rect().size
