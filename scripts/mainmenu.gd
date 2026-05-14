extends Node2D

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

func _on_quit_button_pressed() -> void:
	$buttonClick.play()
	get_tree().quit()

func _on_items_button_pressed() -> void:
	$buttonClick.play()
	get_tree().change_scene_to_file("res://scenes/items.tscn")

func _on_items_button_mouse_entered() -> void:
	$buttonHover.play()

func _on_quit_button_mouse_entered() -> void:
	$buttonHover.play()
