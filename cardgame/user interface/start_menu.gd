extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_bgm(preload("res://assets/bgm/start_bgm.mp3"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
