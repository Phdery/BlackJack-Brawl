extends Area2D

@onready var deck = $".."

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		pass
		# do remove child on game scene
		# pass card deck's array of cards to the deck scene for display
		# do add child on deck scene
		# to make this work, the game scene and deck scene need to be 
		# children of some main scene tree that we can add/remove child to
