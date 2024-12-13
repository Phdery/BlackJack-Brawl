class_name TarotHangmanCard
extends Card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 10
	description = "The Hangman\n Score = 10\n remove random enemy current card "
	# set texture

func mechanism(this:Controller, other:Controller):
	var card = other.displayed_cards.generate_random_card()
	if card:
		other.displayed_cards.move_card_to(card, other.used_card_deck)
		other.start_move_card_animation(card, other.displayed_cards, other.used_card_deck)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
