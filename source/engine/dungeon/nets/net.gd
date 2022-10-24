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

func apply_trans_list(_trans_list):
    pass
