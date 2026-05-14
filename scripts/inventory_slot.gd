extends Panel

var item_data : ItemData
var tooltip_scene = preload("res://scenes/item_tooltip.tscn")

var tooltip

var inventory_index : int = -1

var normal_style : StyleBoxFlat
var hover_style : StyleBoxFlat

@onready var bg = $bgColor

func set_item(item : ItemData, index : int):
	item_data = item
	inventory_index = index
	$iconDisplay.texture = item.icon

func _ready():

	normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.2627451, 0.23529412, 0.20392157)

	hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(0.2627451, 0.23529412, 0.20392157)

	hover_style.border_width_left = 5
	hover_style.border_width_top = 5
	hover_style.border_width_right = 5
	hover_style.border_width_bottom = 5

	hover_style.border_color = Color(0.518, 0.463, 0.412, 1.0)

	bg.add_theme_stylebox_override("panel", normal_style)

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():

	bg.add_theme_stylebox_override("panel", hover_style)

	if item_data == null:
		return

	tooltip = tooltip_scene.instantiate()

	get_tree().current_scene.add_child(tooltip)

	tooltip.set_item(item_data)

func _on_mouse_exited():

	bg.add_theme_stylebox_override("panel", normal_style)

	if tooltip:
		tooltip.queue_free()

func _gui_input(event):

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:

			if inventory_index != -1:
				Inventory.sell_item(inventory_index)
