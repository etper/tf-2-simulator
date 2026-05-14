extends Panel

var item_data : ItemData
var tooltip_scene = preload("res://scenes/item_tooltip.tscn")

var tooltip

func set_item(item : ItemData):

	item_data = item
	$iconDisplay.texture = item.icon

func _ready():

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():

	if item_data == null:
		return

	tooltip = tooltip_scene.instantiate()

	get_tree().current_scene.add_child(tooltip)

	tooltip.set_item(item_data)

	tooltip.global_position = get_global_mouse_position() + Vector2(16, 16)

func _on_mouse_exited():

	if tooltip:
		tooltip.queue_free()
