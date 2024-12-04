extends Area2D

@onready var card = $".."
@onready var label = $"../Label"
@onready var timer = $"../Timer"

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		label.visible = true
		label.text = card.description
		timer.one_shot = true
		timer.wait_time = 5
		timer.start()

func _on_timer_timeout() -> void:
	label.visible = false
