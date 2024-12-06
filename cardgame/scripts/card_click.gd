extends Area2D

@onready var card = $".."


func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		print("clicked")
