extends Node

func add_info_node(parentnode, infoscene, kwargs):
    var infonode = infoscene.instance()
    parentnode.add_child(infonode)
    infonode.set_info(kwargs)
