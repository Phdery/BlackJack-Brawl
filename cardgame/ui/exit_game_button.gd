extends Button

var quit_button = preload("res://assets/title/quit_button.png")
var quit_button_hover = preload("res://assets/title/quit_button_hover.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = quit_button


func _on_mouse_entered() -> void:
	icon = quit_button_hover
	SoundManager.play_sfx("ButtonFocus")


func _on_mouse_exited() -> void:
	icon = quit_button


# Exit the game
func _on_pressed() -> void:
	SoundManager.play_sfx("ButtonPress")
	get_tree().quit()
