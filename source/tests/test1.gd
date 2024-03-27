extends RefCounted

func setup(node):
    node.sig.connect(callback)

func callback():
    print("test1")
