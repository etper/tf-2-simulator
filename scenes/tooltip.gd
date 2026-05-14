extends Panel

@onready var bg = $ColorRect
@onready var box = $ColorRect/VBoxContainer

@onready var name_label = $ColorRect/VBoxContainer/NameLabel
@onready var description_label = $ColorRect/VBoxContainer/DescriptionLabel
@onready var stats_label = $ColorRect/VBoxContainer/StatsLabel

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func set_item(item : ItemData):

	name_label.text = item.display_name
	description_label.text = item.description

	var stats = ""

	update_tooltip_size()

	if item.tags.size() > 0:
		stats += "Tags: " + ", ".join(item.tags) + "\n"

	for key in item.metadata.keys():
		stats += str(key) + ": " + str(item.metadata[key]) + "\n"

	stats_label.text = stats

func _process(delta):
	global_position = get_global_mouse_position() + Vector2(16, 16)

func update_tooltip_size():

	await get_tree().process_frame

	var padding = Vector2(24, 24)

	bg.size = box.size + padding

	# center the VBoxContainer inside the bg
	box.position = (bg.size - box.size) / 2.0

	size = bg.size
