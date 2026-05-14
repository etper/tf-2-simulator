extends Button

var hover_sound = preload("res://sfx/tf2-button-click-hover.mp3")
var click_sound = preload("res://sfx/tf2-button-click.mp3")

var hover_player : AudioStreamPlayer
var click_player : AudioStreamPlayer

func _ready():

	hover_player = AudioStreamPlayer.new()
	click_player = AudioStreamPlayer.new()

	add_child(hover_player)
	add_child(click_player)

	hover_player.stream = hover_sound
	click_player.stream = click_sound

	mouse_entered.connect(func(): hover_player.play())
	pressed.connect(func(): click_player.play())
