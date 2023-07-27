extends RefCounted

# variables
var poslist
var centeridx
var centerpos : get = get_centerpos

func _init():
    create_poslist()
    #GODOT4: replace for Vector2i
    centeridx = poslist.find(Vector2(0,0))

# setget functions
func get_centerpos():
    return poslist[centeridx]

# public function
func create_poslist():
    pass

func offset(offset):
    for i in len(poslist):
        poslist[i] = poslist[i]+offset

func apply_trans_list(trans_list):
    for trans in trans_list:
        apply_trans(trans)

# private functions
func apply_trans(trans):
    match trans:
        "TCW" : apply_turn_clock_wise()
        "TAW" : apply_turn_anticlock_wise()
        "FUD" : apply_flip_up_down()
        "FLR" : apply_flip_left_right()

func apply_turn_clock_wise():
    for i in len(poslist):
        var pos = poslist[i]
        poslist[i].x = self.centerpos.x+(pos.y-self.centerpos.y) # mathemagics
        poslist[i].y = self.centerpos.y-(pos.x-self.centerpos.x) # mathemagics

func apply_turn_anticlock_wise():
    for i in len(poslist):
        var pos = poslist[i]
        poslist[i].x = self.centerpos.x-(pos.y-self.centerpos.y) # mathemagics
        poslist[i].y = self.centerpos.y+(pos.x-self.centerpos.x) # mathemagics

func apply_flip_up_down():
    for i in len(poslist):
        poslist[i].y = 2*self.centerpos.y-poslist[i].y # mathemagics

func apply_flip_left_right():
    for i in len(poslist):
        poslist[i].x = 2*self.centerpos.x-poslist[i].x # mathemagics
