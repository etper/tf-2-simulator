extends Node

signal inventory_changed
signal notifications_changed
var notification_sound = preload("res://sfx/tf2-notification-sound.mp3")

var items : Array[Dictionary] = []
var pending_items : Array[Dictionary] = []

func _ready():

	var player = AudioStreamPlayer.new()
	player.name = "NotificationPlayer"
	player.stream = notification_sound

	add_child(player)

func add_item(item_id : String, amount := 1):

	pending_items.append({
		"id": item_id,
		"amount": amount
	})

	$NotificationPlayer.play()

	notifications_changed.emit()

func remove_item(index : int):
	if index >= 0 and index < items.size():
		items.remove_at(index)

func clear_inventory():
	items.clear()
	
	inventory_changed.emit()

func print_inventory():
	print("=== INVENTORY ===")

	for item in items:
		var data = ItemDatabase.get_item(item["id"])

		if data:
			print(data.display_name)

func remove_item_by_id(item_id : String):

	for i in range(items.size() - 1, -1, -1):

		if items[i]["id"] == item_id:
			items.remove_at(i)
			inventory_changed.emit()
			return

func claim_next_item():

	if pending_items.is_empty():
		return

	var item = pending_items.pop_front()

	items.append(item)

	inventory_changed.emit()
	notifications_changed.emit()
