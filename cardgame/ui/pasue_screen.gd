extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	if Input.is_action_just_pressed("pause"):
		show()
		get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_resume_button_pressed() -> void:
	SoundManager.play_sfx("ButtonPress")
	hide()
	get_tree().paused = false


func _on_quit_button_pressed() -> void:
	SoundManager.play_sfx("ButtonPress")
	get_tree().quit()


func _on_resume_button_mouse_entered() -> void:
	SoundManager.play_sfx("ButtonStart")


func _on_quit_button_mouse_entered() -> void:
	SoundManager.play_sfx("ButtonStart")
