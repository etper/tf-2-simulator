extends CanvasLayer

@onready var input = $LineEdit

func _ready():
	visible = false

func _input(event):

	if event.is_action_pressed("ui_cancel"):
		visible = !visible
		input.grab_focus()

		if visible:
			input.grab_focus()

func _on_line_edit_text_submitted(text):

	parse_command(text)

	input.text = ""

func parse_command(command : String):

	var parts = command.split(" ")

	if parts.is_empty():
		return

	match parts[0]:

		"add":

			if parts.size() > 1:
				Inventory.add_item(parts[1])
				print("Added items")

		"remove":

			if parts.size() > 1:
				Inventory.remove_item_by_id(parts[1])
				print("Removed items")

		"clear":

			Inventory.clear_inventory()
			print("Cleared inventory!")

		"print":

			Inventory.print_inventory()
