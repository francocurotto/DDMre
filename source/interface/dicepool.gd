extends VBoxContainer

const MAXSELECTED = 3

func fill(dicelist):
	for i in dicelist.size():
		var diceitem = get_child(i)
		diceitem.update_item(dicelist[i])
		diceitem.update_index(i+1)
		diceitem.get_node("Button").connect("pressed", self, "_on_diceitem_pressed")

func _on_diceitem_pressed():
	if get_nselected() >= MAXSELECTED:
		disable_unselected()
	else:
		enable_all()

func get_nselected():
	"""
	Get the number of dice items that are selected.
	"""
	var n = 0
	for diceitem in get_children():
		n += int(diceitem.get_node("Button").pressed)
	return n

func disable_unselected():
	"""
	Disable selection for dice items that are not selected.
	"""
	for diceitem in get_children():
		if not diceitem.get_node("Button").pressed:
			diceitem.get_node("Button").disabled = true

func enable_all():
	"""
	Enable all dice items.
	"""
	for diceitem in get_children():
		diceitem.get_node("Button").disabled = false

func rollready():
	"""
	Returns true if already selected all the dice to roll.
	"""
	return get_nselected() == MAXSELECTED

func get_selectedindeces():
	"""
	Return the indeces of the selected dice to roll.
	"""
	var indeces = []
	for i in get_child_count():
		if get_child(i).get_node("Button").pressed:
			indeces.append(i)
	return indeces
