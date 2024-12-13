extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.stop_start()
	SoundManager.play_sfx("StartBGM")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
