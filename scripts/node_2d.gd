extends Node2D

@export var slot_scene : PackedScene
@export var slot_count := 50

@onready var grid = $"../CenterContainer/GridContainer"

func _ready():
	for i in range(slot_count):
		var slot = slot_scene.instantiate()
		grid.add_child(slot)
