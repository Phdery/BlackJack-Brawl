extends Button

var stand_button = preload("res://assets/table/stand.png")
var stand_button_hover = preload("res://assets/table/stand_hover.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = stand_button


func _on_mouse_entered() -> void:
	icon = stand_button_hover
	SoundManager.play_sfx("ButtonFocus")


func _on_mouse_exited() -> void:
	icon = stand_button


func _on_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
