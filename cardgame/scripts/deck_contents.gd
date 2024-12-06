extends Node2D

var cards:Array[Card]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# test code for adding one card child 
	var test_card:Card = BasicCard.new(5, "club")
	add_child(test_card)
	test_card.scale = Vector2(0.5,0.5)
	test_card.global_position = Vector2(150,200)
	# loop through all card objects
		# for each one, do add child, then adjust scale and position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# func for accepting the carddeck array?
# button that when clicked, removes all card nodes, returns to game scene
# label for description
# function for accepting new text for label
