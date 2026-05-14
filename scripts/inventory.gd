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
