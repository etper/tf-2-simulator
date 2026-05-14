extends Node

signal inventory_changed
signal notifications_changed
var notification_sound = preload("res://sfx/tf2-notification-sound.mp3")

const QUALITIES = {
	"normal": {
		"display": "Normal",
		"color": Color("b2b2b2")
	},
	"unique": {
		"display": "Unique",
		"color": Color("ffd700")
	},
	"strange": {
		"display": "Strange",
		"color": Color("cf6a32")
	},
	"vintage": {
		"display": "Vintage",
		"color": Color("476291")
	},
	"unusual": {
		"display": "Unusual",
		"color": Color("8650ac")
	}
}

var credits : float = 0.0
var items : Array[ItemInstance] = []
var pending_items : Array[ItemInstance] = []

const SAVE_PATH = "D:/savegame.json"

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

func add_item(item_id : String, amount := 1, quality := "unique"):

	var item = ItemInstance.new()

	item.definition_id = item_id
	item.amount = amount
	item.quality = quality

	pending_items.append(item)

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
		var data = item.get_definition()

		if data:
			print(data.display_name)

func remove_item_by_id(item_id : String):

	for i in range(items.size() - 1, -1, -1):

		if items[i].definition_id == item_id:
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
	var item_data = item_entry.get_definition()

	if item_data:
		credits += (item_data.value)/100.0

		$SellPlayer.play()

	items.remove_at(index)

	inventory_changed.emit()
	
	save_game()

func save_game():

	var save_items = []
	for item in items:
		save_items.append({
			"definition_id": item.definition_id,
			"amount": item.amount,
			"unique_id": item.unique_id,
			"crate_series": item.crate_series,
			"opened": item.opened,
			"quality": item.quality,
			"custom_name": item.custom_name
		})

	var save_pending = []
	for item in pending_items:
		save_pending.append({
			"definition_id": item.definition_id,
			"amount": item.amount,
			"unique_id": item.unique_id,
			"crate_series": item.crate_series,
			"opened": item.opened,
			"quality": item.quality,
			"custom_name": item.custom_name
		})

	var save_data = {
		"credits": credits,
		"items": save_items,
		"pending_items": save_pending
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

	for item_data in data.get("items", []):

		var item = ItemInstance.new()

		item.definition_id = item_data.get("definition_id", "")
		item.amount = item_data.get("amount", 1)
		item.unique_id = item_data.get("unique_id", "")
		item.crate_series = item_data.get("crate_series", 0)
		item.opened = item_data.get("opened", false)
		item.quality = item_data.get("quality", "normal")
		item.custom_name = item_data.get("custom_name", "")

		items.append(item)

	pending_items.clear()

	for item_data in data.get("pending_items", []):

		var item = ItemInstance.new()

		item.definition_id = item_data.get("definition_id", "")
		item.amount = item_data.get("amount", 1)
		item.unique_id = item_data.get("unique_id", "")
		item.crate_series = item_data.get("crate_series", 0)
		item.opened = item_data.get("opened", false)
		item.quality = item_data.get("quality", "normal")
		item.custom_name = item_data.get("custom_name", "")

		pending_items.append(item)

	inventory_changed.emit()
	notifications_changed.emit()

func roll_quality() -> String:

	var roll = randf()

	if roll <= 0.01:
		return "unusual"

	if roll <= 0.05:
		return "strange"

	if roll <= 0.10:
		return "vintage"

	return "unique"
