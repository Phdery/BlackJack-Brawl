extends Button

var start_button = preload("res://assets/title/start_button.png")
var start_button_hover = preload("res://assets/title/start_button_hover.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = start_button


func _on_mouse_entered() -> void:
	icon = start_button_hover
	SoundManager.play_sfx("ButtonFocus")


func _on_mouse_exited() -> void:
	icon = start_button
	pass # Replace with function body.


func _on_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
	MainGame._start_round()
