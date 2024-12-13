class_name DeckContents
extends Node2D


var cards:Array[Card]
var basic_card_scene = preload("res://scenes/basic_card.tscn")
@onready var label_control:Control = $LabelControl
@onready var label:Label = $LabelControl/Label
@onready var button:Button = $Button
@onready var deck = $".."
@onready var color_rect = $ColorRect


func _ready() -> void:
	# Set position to (0, 0)
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	self.z_index = 50
	global_position = Vector2(0, 0)

	# Scale the DeckContents node to match the viewport size
	var viewport_size = Vector2(get_viewport().size)
	var original_size = Vector2(1, 1) 
	color_rect.scale = viewport_size / original_size

	#label.scale = Vector2(6,6)
	#label.global_position = label.position
	label_control.top_level = true
	label_control.z_index = 51
	label_control.position = Vector2(700, 0) # Position it at (20, 20) relative to the window
	#label_control.scale = Vector2(6, 6)
	
	#button.scale = Vector2(3,3)
	#button.global_position.x += 500
	self.visible = true
	cards = deck.cards
	deck.connect("clicked", display_cards)
	
	
func _on_card_hovered(card:Card):
	# show description of card being hovered over
	label.text = card.description 
	
	
func _on_card_exited():
	pass
	#label.text = ""


func display_cards() -> void:
	
	for card in cards:
		card.mouse_entered.connect(_on_card_hovered.bind(card))
		card.mouse_exited.connect(_on_card_exited)
	
	cards = deck.cards
	print("Displaying ", str(len(cards)), " Cards")
	self.visible = true
	#label.global_position = Vector2(15 + 31 * 6, 20)
	#button.global_position = Vector2(15 + 31 * 6, 50)
	var start_position = Vector2(50,200)
	var num_per_row:int = 6
	var i:int = 0
	var y:int = -1
	
	# loop through all card objects
	# for each one, do add child, then adjust scale and position
	for card in cards:
		add_child(card)
		card.scale = Vector2(0.7, 0.7)
		if (i % num_per_row == 0):
			y += 1
		card.global_position = start_position + Vector2(100 * (i % num_per_row), 150 * y)
		i += 1
		
	
func exit_scene() -> void:
	# return to game scene
	self.visible = false
	for card in cards:
		remove_child(card)


func _on_button_2_pressed() -> void:
	print("test pressed")
	exit_scene()
