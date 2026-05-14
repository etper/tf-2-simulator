extends Node2D

@onready var alert_icon = $AlertIcon

var backgrounds = [
	"res://sprites/bgs/2fortbg.png",
	"res://sprites/bgs/upwardbg.png",
	"res://sprites/bgs/mvmbg.png",
	"res://sprites/bgs/gravelpitbg.png"
]

var heroes = [
	"res://sprites/heroes/hero1.png",
	"res://sprites/heroes/hero2.png",
	"res://sprites/heroes/hero3.png",
	"res://sprites/heroes/hero4.png",
	"res://sprites/heroes/hero5.png",
	"res://sprites/heroes/hero6.png",
	"res://sprites/heroes/hero7.png",
	"res://sprites/heroes/hero8.png",
	"res://sprites/heroes/hero9.png"
]

func _ready():
	var random_bg = backgrounds.pick_random()
	var random_hero = heroes.pick_random()
	
	$hero.texture = load(random_hero)
	$backgroundMap.texture = load(random_bg)
	
	Inventory.notifications_changed.connect(update_alert)
	update_alert()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_items_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/items.tscn")

func update_alert():

	var count = Inventory.pending_items.size()

	alert_icon.visible = count > 0

	if count > 0:
		alert_icon.get_node("Label").text = str(count)

func _on_find_game_button_pressed() -> void:

	print("Searching for match...")

	# 35% chance to get an item
	var drop_chance = 0.35

	if randf() <= drop_chance:

		var possible_items = [
			"1" # scattergun
		]

		var random_item = possible_items.pick_random()

		var quality = Inventory.roll_quality()

		Inventory.add_item(random_item, 1, quality)

		print("Item found!")
	else:
		print("No item drop.")
