extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.has_stop_all_called = false
	SoundManager.stop_all()
	SoundManager.play_sfx("StartBGM")
	SoundManager.has_stop_all_called = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
