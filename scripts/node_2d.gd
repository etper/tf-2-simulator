extends Node2D

@export var slot_scene : PackedScene
@export var slot_count := 50

@onready var grid = $"../CenterContainer/GridContainer"

func _ready():
	Inventory.inventory_changed.connect(refresh_inventory)
	
	refresh_inventory()

func refresh_inventory():

	# clear old slots
	for child in grid.get_children():
		child.queue_free()

	# rebuild slots
	for i in range(slot_count):

		var slot = slot_scene.instantiate()

		if i < Inventory.items.size():

			var item_data = Inventory.items[i]
			var item = ItemDatabase.get_item(item_data["id"])

			if item:
				slot.set_item(item, i)

		grid.add_child(slot)
