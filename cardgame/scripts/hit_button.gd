extends Button

var hit_button = preload("res://assets/table/hit.png")
var hit_button_hover = preload("res://assets/table/hit_hover.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = hit_button


func _on_mouse_entered() -> void:
	icon = hit_button_hover
	SoundManager.play_sfx("ButtonFocus")


func _on_mouse_exited() -> void:
	icon = hit_button


func _on_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
