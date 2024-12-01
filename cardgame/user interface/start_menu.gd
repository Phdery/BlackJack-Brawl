extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_bgm(preload("res://assets/bgm/start_bgm.mp3"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_pressed() -> void:
	pass # Replace with function body.


func _on_exit_game_pressed() -> void:
	get_tree().quit()
