class_name DeckContents
extends Node2D

var cards:Array[Card]
var basic_card_scene = preload("res://scenes/basic_card.tscn")
# Called when the node enters the scene tree for the first time.
@onready var label:Label = $Label
@onready var button:Button = $Button
@onready var deck = $".."

func _ready() -> void:
	self.visible = true
	self.label.global_position = Vector2(150 + 310 * 6, 200)
	self.button.global_position = Vector2(150 + 310 * 6, 500)
	cards = deck.cards
	# test code for adding card children
	var test_card_1 = basic_card_scene.instantiate()
	test_card_1.custom_init(2,"heart")
	cards.append(test_card_1)
	
	var test_card_2 = basic_card_scene.instantiate()
	test_card_2.custom_init(3,"heart")
	cards.append(test_card_2)
	
	var test_card_3 = basic_card_scene.instantiate()
	test_card_3.custom_init(4,"heart")
	cards.append(test_card_3)
	
	var test_card_4 = basic_card_scene.instantiate()
	test_card_4.custom_init(5,"heart")
	cards.append(test_card_4)
	
	var test_card_5 = basic_card_scene.instantiate()
	test_card_5.custom_init(6,"heart")
	cards.append(test_card_5)
	
	var test_card_6 = basic_card_scene.instantiate()
	test_card_6.custom_init(7,"heart")
	cards.append(test_card_6)
	
	var test_card_7 = basic_card_scene.instantiate()
	test_card_7.custom_init(8,"heart")
	cards.append(test_card_7)
	
	var test_card_8 = basic_card_scene.instantiate()
	test_card_8.custom_init(9,"heart")
	cards.append(test_card_8)
	
	var test_card_9 = basic_card_scene.instantiate()
	test_card_9.custom_init(10,"heart")
	cards.append(test_card_9)
	
	var test_card_10 = basic_card_scene.instantiate()
	test_card_10.custom_init(2,"heart")
	cards.append(test_card_10)
	
	var test_card_11 = basic_card_scene.instantiate()
	test_card_11.custom_init(3,"heart")
	cards.append(test_card_11)
	
	var test_card_12 = basic_card_scene.instantiate()
	test_card_12.custom_init(4,"heart")
	cards.append(test_card_12)
	
	var test_card_13 = basic_card_scene.instantiate()
	test_card_13.custom_init(5,"heart")
	cards.append(test_card_13)
	
	var test_card_14 = basic_card_scene.instantiate()
	test_card_14.custom_init(6,"heart")
	cards.append(test_card_14)
	
	var test_card_15 = basic_card_scene.instantiate()
	test_card_15.custom_init(7,"heart")
	cards.append(test_card_15)
	
	var test_card_16 = basic_card_scene.instantiate()
	test_card_16.custom_init(8,"heart")
	cards.append(test_card_16)
	
	var test_card_17 = basic_card_scene.instantiate()
	test_card_17.custom_init(9,"heart")
	cards.append(test_card_17)
	
	var test_card_18 = basic_card_scene.instantiate()
	test_card_18.custom_init(10,"heart")
	cards.append(test_card_18)
	
	for card in cards:
		#card.connect("mouse_entered", _on_card_hovered)
		#card.connect("mouse_exited", _on_card_exited)
		card.mouse_entered.connect(_on_card_hovered.bind(card))
		card.mouse_exited.connect(_on_card_exited)
	
	
	deck.connect("clicked", display_cards)	#
	
func _on_card_hovered(card:Card):
	label.text = card.description
	
func _on_card_exited():
	label.text = ""

func display_cards() -> void:
	cards = deck.cards
	self.visible = true
	label.global_position = Vector2(150 + 310 * 6, 200)
	button.global_position = Vector2(150 + 310 * 6, 500)
	var start_position = Vector2(150,200)
	var num_per_row:int = 6
	var i:int = 0
	var y:int = -1
	# loop through all card objects
	# for each one, do add child, then adjust scale and position
	for card in cards:
		add_child(card)
		card.scale = Vector2(0.5, 0.5)
		if (i % num_per_row == 0):
			y += 1
		card.global_position = start_position + Vector2(310 * (i % num_per_row), 410 * y)
		i += 1
		

func change_label(text:String) -> void:
	label.text = text
	
func exit_scene() -> void:
	self.visible = false
	remove_child(self)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# func for accepting the carddeck array?
# button that when clicked, removes all card nodes, returns to game scene
# label for description
# function for accepting new text for label
