extends Node

var items : Array[Dictionary] = []

func _ready():
	add_item("1")
	add_item("1")

func add_item(item_id : String, amount := 1):
	items.append({
		"id": item_id,
		"amount": amount
	})

func remove_item(index : int):
	if index >= 0 and index < items.size():
		items.remove_at(index)

func clear_inventory():
	items.clear()

func print_inventory():
	print("=== INVENTORY ===")

	for item in items:
		var data = ItemDatabase.get_item(item["id"])

		if data:
			print(data.display_name)
