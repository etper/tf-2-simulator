extends Node2D

func _on_items_button_pressed() -> void:
	$buttonClick.play()
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")


func _on_items_button_mouse_entered() -> void:
	$buttonHover.play()
