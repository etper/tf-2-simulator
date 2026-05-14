extends Button

@onready var mat = material

func _ready():
	mat.set_shader_parameter("saturation", 0.0)

func _on_mouse_entered():
	mat.set_shader_parameter("saturation", 1.0)
	$"../buttonHover".play()

func _on_mouse_exited():
	mat.set_shader_parameter("saturation", 0.0)
