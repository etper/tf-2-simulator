extends Node

var items = []

func _ready():
	return

func add_item(item_name):
	items.append(item_name)
	print("New item: " + item_name)
	print("Inventory so far: " + str(items))
