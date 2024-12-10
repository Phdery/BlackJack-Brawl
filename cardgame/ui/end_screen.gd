extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#hide()
	pass


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
