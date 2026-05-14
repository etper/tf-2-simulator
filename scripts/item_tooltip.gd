extends Panel

@onready var name_label = $VBoxContainer/NameLabel
@onready var description_label = $VBoxContainer/DescriptionLabel
@onready var stats_label = $VBoxContainer/StatsLabel
@onready var bg = $ColorRect
@onready var vbox = $VBoxContainer

func set_item(item : ItemData, instance : ItemInstance):
	
	var quality_data = Inventory.QUALITIES.get(instance.quality)
	
	if quality_data:
		name_label.modulate = quality_data.color

	if quality_data:
		name_label.modulate = quality_data.color
		name_label.text = "%s %s" % [
			quality_data.display,
			item.display_name
		]
	else:
		name_label.text = item.display_name

	description_label.text = item.description

	var stats = ""

	if item.tags.size() > 0:
		stats += "Tags: " + ", ".join(item.tags) + "\n"

	for value in item.metadata.values():
		stats += str(value) + "\n"

	stats_label.text = stats
	
	vbox.reset_size()

	await get_tree().process_frame

	bg.size = vbox.get_combined_minimum_size() + Vector2(24, 24)
	
	var content_size = vbox.get_combined_minimum_size()

	bg.size = content_size + Vector2(24, 24)

	vbox.position = (bg.size - content_size) / 2

func _process(delta):

	global_position = get_global_mouse_position() + Vector2(16, 16)
