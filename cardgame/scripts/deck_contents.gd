extends Node2D

var cards:Array[Card]
var basic_card_scene = preload("res://scenes/basic_card.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# test code for adding one card child 
	#var test_card:Card = BasicCard.new(5, "heart")
	var test_card:BasicCard = basic_card_scene.instantiate()
	#test_card.suit = "heart"
	#test_card.score = 6
	#test_card.update_texture()
	test_card.costum_init(6,"heart")
	print(test_card.get_class())
	add_child(test_card)
	test_card.scale = Vector2(0.5,0.5)
	test_card.global_position = Vector2(300,300)
	
	var test_card_2:BasicCard = basic_card_scene.instantiate()
	#test_card_2.suit = "spade"
	#test_card_2.score = 8
	#test_card_2.update_texture()
	test_card_2.costum_init(8,"spade")
	print(test_card_2.get_class())
	add_child(test_card_2)
	test_card_2.scale = Vector2(0.5,0.5)
	test_card_2.global_position = Vector2(600,300)
	
	# loop through all card objects
		# for each one, do add child, then adjust scale and position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# func for accepting the carddeck array?
# button that when clicked, removes all card nodes, returns to game scene
# label for description
# function for accepting new text for label
