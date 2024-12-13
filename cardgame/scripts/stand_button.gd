extends Button


var stand_button = preload("res://assets/table/stand_button.png")
var stand_button_hover = preload("res://assets/table/stand_button_pressed.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = stand_button


func _on_mouse_entered() -> void:
	SoundManager.play_sfx("ButtonFocus")


func _on_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
