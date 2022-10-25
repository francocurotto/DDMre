extends Reference

# variables
var poslist
var idxlist setget , get_idxlist
var centeridx
var centerpos setget , get_centerpos

# setget functions
func get_idxlist():
    return range(len(poslist))

func set_centeridx():
    for i in self.idxlist:
        if poslist[i] == Vector2(0,0):
            centeridx = i
            return

func get_centerpos():
    return poslist[centeridx]

# public function
func offset(offset):
    for i in self.idxlist:
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
    pass

func apply_turn_anticlock_wise():
    pass

func apply_flip_up_down():
    pass

func apply_flip_left_right():
    for i in self.idxlist:
        print(poslist[i].x)
        poslist[i].x -= poslist[i].x - centerpos.x 
