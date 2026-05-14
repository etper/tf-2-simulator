extends Panel

@onready var name_label = $VBoxContainer/NameLabel
@onready var description_label = $VBoxContainer/DescriptionLabel
@onready var stats_label = $VBoxContainer/StatsLabel

func set_item(item : ItemData):

	name_label.text = item.display_name

	description_label.text = item.description

	var stats = ""

	if item.tags.size() > 0:
		stats += "Tags: " + ", ".join(item.tags) + "\n"

	for key in item.metadata.keys():
		stats += str(key) + ": " + str(item.metadata[key]) + "\n"

	stats_label.text = stats

func _process(delta):

	global_position = get_global_mouse_position() + Vector2(16, 16)
