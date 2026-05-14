extends Node

var items : Dictionary = {}

func _ready():
	load_all_items()

func load_all_items():
	scan_directory("res://items/data")

func scan_directory(path : String):
	var dir = DirAccess.open(path)

	if dir == null:
		return

	dir.list_dir_begin()

	while true:
		var file_name = dir.get_next()

		if file_name == "":
			break

		var full_path = path + "/" + file_name

		if dir.current_is_dir():
			scan_directory(full_path)

		elif file_name.ends_with(".tres"):
			var item = load(full_path)

			if item is ItemData:
				items[item.id] = item

	dir.list_dir_end()

func get_item(id : String) -> ItemData:
	return items.get(id)

func has_item(id : String) -> bool:
	return items.has(id)
