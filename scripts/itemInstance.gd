extends Resource
class_name ItemInstance

@export var definition_id : String
@export var amount : int = 1

# unique data
@export var unique_id : String = ""

# crate stuff
@export var crate_series : int = 0
@export var opened : bool = false

# cosmetic/random rolls
@export var quality : String = "normal"
@export var custom_name : String = ""

func get_definition() -> ItemData:
	return ItemDatabase.get_item(definition_id)
