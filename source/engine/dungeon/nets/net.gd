extends Reference

# variables
var poslist
var idxlist setget , get_idxlist

# setget functions
func get_idxlist():
    return range(len(poslist))

func offset(offset):
    for i in self.idxlist:
        poslist[i] = poslist[i]+offset
