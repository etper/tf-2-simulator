extends Label

func _ready():

	Inventory.inventory_changed.connect(update_display)

	update_display()

func update_display():

	text = "$%.2f" % Inventory.credits
