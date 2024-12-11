extends Control


@onready var back_button: Button = $BackStart
@onready var background: Sprite2D = $Background

var back_to_start = preload("res://assets/ending/try_again.png")
var back_to_start_hover = preload("res://assets/ending/try_again_hover.png")
var background_fail = preload("res://assets/ending/fail_1.jpg")
var background_win = preload("res://assets/ending/win_2.jpg")
var table = preload("res://scenes/table.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_button.icon = back_to_start
	table.connect("player_win", _on_player_win())
	table.connect("player_fail", _on_player_fail())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if (
		event is InputEventKey or
		event is InputEventMouseButton or
		event is InputEventJoypadButton
	):
		if event.is_pressed() and not event.is_echo():
			pass

func show_game_over() -> void:
	show()


func _on_back_start_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
	get_tree().change_scene_to_file("res://ui/start_menu.tscn")


func _on_back_start_mouse_entered() -> void:
	SoundManager.play_sfx("ButtonFocus")
	back_button.icon = back_to_start_hover


func _on_back_start_mouse_exited() -> void:
	back_button.icon = back_to_start


func _on_player_win():
	background.texture = background_win


func _on_player_fail():
	background.texture = background_fail
