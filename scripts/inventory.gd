extends Node

signal inventory_changed
signal notifications_changed
var notification_sound = preload("res://sfx/tf2-notification-sound.mp3")

var credits : float = 0.0
var items : Array[Dictionary] = []
var pending_items : Array[Dictionary] = []

const SAVE_PATH = "user://savegame.json"

var sell_sound = preload("res://sfx/sell.wav")

func _ready():

	var player = AudioStreamPlayer.new()
	player.name = "NotificationPlayer"
	player.stream = notification_sound
	
	var sell_player = AudioStreamPlayer.new()
	sell_player.name = "SellPlayer"
	sell_player.stream = sell_sound

	add_child(sell_player)

	add_child(player)
	
	load_game()
	
	add_item("2")

func add_item(item_id : String, amount := 1):

	pending_items.append({
		"id": item_id,
		"amount": amount
	})

	$NotificationPlayer.play()

	notifications_changed.emit()
	
	save_game()

func remove_item(index : int):
	if index >= 0 and index < items.size():
		items.remove_at(index)
	
	save_game()

func clear_inventory():
	items.clear()
	
	inventory_changed.emit()
	
	save_game()

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
	
	save_game()

func claim_next_item():

	if pending_items.is_empty():
		return

	var item = pending_items.pop_front()

	items.append(item)

	inventory_changed.emit()
	notifications_changed.emit()
	
	save_game()

func sell_item(index : int):

	if index < 0 or index >= items.size():
		return

	var item_entry = items[index]
	var item_data = ItemDatabase.get_item(item_entry["id"])

	if item_data:
		credits += (item_data.value)/100.0

		$SellPlayer.play()

	items.remove_at(index)

	inventory_changed.emit()
	
	save_game()

func save_game():

	var save_data = {
		"credits": credits,
		"items": items,
		"pending_items": pending_items
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)

	if file:
		file.store_string(JSON.stringify(save_data))

func load_game():

	if not FileAccess.file_exists(SAVE_PATH):
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)

	if file == null:
		return

	var json_text = file.get_as_text()

	var data = JSON.parse_string(json_text)

	if typeof(data) != TYPE_DICTIONARY:
		return

	credits = data.get("credits", 0.0)
	items.clear()

	for item in data.get("items", []):
		items.append(item)

	pending_items.clear()

	for item in data.get("pending_items", []):
		pending_items.append(item)

	inventory_changed.emit()
	notifications_changed.emit()
