extends Control


@onready var back_button: Button = $BackStart
@onready var exit_button: Button = $ExitGame
@onready var background: Sprite2D = $Background

var back_to_start = preload("res://assets/ending/try_again.png")
var back_to_start_hover = preload("res://assets/ending/lets_go_hover.png")
var back_start_win = preload("res://assets/ending/return_main.png")
var background_fail = preload("res://assets/ending/fail_1.jpg")
var background_win = preload("res://assets/ending/win_2.jpg")
var exit_normal = preload("res://assets/ending/exit.png")
var exit_hover = preload("res://assets/ending/exit_hover.png")
var table = preload("res://scenes/table.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_button.icon = back_to_start
	GameGlobal.player_win.connect(on_player_win)
	GameGlobal.player_fail.connect(on_player_fail)
	match GameGlobal.game_state:
		GameGlobal.GameState.PLAYER_WIN:
			background.texture = background_win
			back_button.icon = back_start_win
		GameGlobal.GameState.PLAYER_FAIL:
			background.texture = background_fail
			back_button.icon = back_to_start
		_:
			print("Unknown game state!")


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
	if (GameGlobal.player_win):
		back_button.icon = back_start_win
	else:
		back_button.icon = back_to_start


func on_player_win():
	print("win called")
	background.texture = background_win
	back_button.icon = back_start_win


func on_player_fail():
	background.texture = background_fail
	back_button.icon = back_to_start


func _on_exit_game_pressed() -> void:
	SoundManager.play_sfx("ButtonPress")
	get_tree().quit()


func _on_exit_game_mouse_entered() -> void:
	SoundManager.play_sfx("ButtonFocus")
	exit_button.icon = exit_hover
	


func _on_exit_game_mouse_exited() -> void:
	exit_button.icon = exit_normal
