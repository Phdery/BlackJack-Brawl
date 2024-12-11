extends Area2D

@onready var deck = $".."

#func _input_event(viewport, event, shape_idx):
	#if event.is_action_pressed("click"):
		#print("clicked")
		## make current scene invisble
		## call display cards function in deckcontents scene, pass in cards array
		#deck.display_contents()
