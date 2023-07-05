extends Reference

var i

func _init(_i):
    i = _i

func duplicate():
    return get_script().new(i)
