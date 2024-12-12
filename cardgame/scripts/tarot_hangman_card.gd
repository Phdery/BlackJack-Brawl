class_name TarotHangmanCard
extends Card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 10
	description = "Move random card from enemy's hand to graveyard. Score = 10"
	# set texture

func mechanism(this:Controller, other:Controller):
	var card = other.display_deck.generate_random_card()
	other.display_deck.move_to(card, other.used_deck)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
