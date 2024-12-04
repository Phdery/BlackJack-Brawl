extends Area2D

@onready var deck = $".."
@onready var label = $"../Label"
@onready var timer = $"../Timer"

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		label.visible = true
		label.text = ""
		for card in deck.cards:
			label.text += card.description + "\n"
		timer.one_shot = true
		timer.wait_time = 5
		timer.start()

func _on_timer_timeout() -> void:
	label.visible = false
