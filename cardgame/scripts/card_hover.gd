extends Area2D

@onready var card = $".."

#func _input_event(viewport, event, shape_idx):
	#if event.is_action_pressed("click"):
		#print("clicked")
#func _ready():
	#connect("mouse_entered", _on_hover)
	#connect("mouse_exited", _on_exit)
	

#func _on_mouse_entered() -> void:	
	#print(card.description)
	#emit_signal("mouse_entered")
	#
#func _on_mouse_exited() -> void:
	#print("Exited")
	#emit_signal("mouse_exited")
