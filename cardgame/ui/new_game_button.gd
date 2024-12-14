extends Button

var start_button = preload("res://assets/title/start_button.png")
var start_button_hover = preload("res://assets/title/start_button_hover.png")
var scene_transition = preload("res://scenes/scene_transition.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = start_button


func _on_mouse_entered() -> void:
	icon = start_button_hover
	SoundManager.play_sfx("ButtonFocus")


func _on_mouse_exited() -> void:
	icon = start_button


# Go the selection menu
func _on_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
	get_tree().change_scene_to_file("res://scenes/select_menu.tscn")
	#get_tree().change_scene_to_file("res://scenes/table.tscn")
	#MainGame._start_round()
