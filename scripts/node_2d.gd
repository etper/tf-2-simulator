extends Node2D

@export var slot_scene : PackedScene
@export var slot_count := 50

@onready var grid = $"../CenterContainer/GridContainer"

func _ready():

	for i in range(slot_count):

		var slot = slot_scene.instantiate()

		# if inventory has item for this slot
		if i < Inventory.items.size():

			var item_data = Inventory.items[i]
			var item = ItemDatabase.get_item(item_data["id"])

			slot.set_item(item)

		grid.add_child(slot)
