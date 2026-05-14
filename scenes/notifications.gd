extends Control

@onready var icon = $ItemIcon
@onready var label = $VBoxContainer/ItemName
@onready var claim_button = $claimButton
@onready var stats_label = $VBoxContainer/StatsLabel
@onready var description_label = $VBoxContainer/DescriptionLabel

func _ready():
	show_current_item()

func show_current_item():

	if Inventory.pending_items.is_empty():
		get_tree().change_scene_to_file("res://scenes/items.tscn")
		return

	var item_data = Inventory.pending_items[0]
	var item = ItemDatabase.get_item(item_data["id"])

	icon.texture = item.icon

	label.text = item.display_name

	description_label.text = item.description

	var stats = ""

	if item.tags.size() > 0:
		stats += "Tags: " + ", ".join(item.tags) + "\n"

	for value in item.metadata.values():
		stats += str(value) + "\n"

	stats_label.text = stats

	var remaining = Inventory.pending_items.size()

	if remaining == 1:
		claim_button.text = "CLAIM ITEM (1)"
	else:
		claim_button.text = "CLAIM ITEM (%d)" % remaining

func _on_claim_button_pressed():

	Inventory.claim_next_item()

	show_current_item()
