extends VBoxContainer

func add_info_node(infoscene, kwargs):
    var infonode = infoscene.instance()
    add_child(infonode)
    infonode.set_info(kwargs)
