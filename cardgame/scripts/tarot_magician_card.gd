class_name TarotMagicianCard
extends Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 10
	description = "Take a random card from enemy's hand. Score = 10"

func mechanism(this:Controller, other:Controller):
	var card = other.displayed_cards.generate_random_card()
	other.move_card_to(card, this.displayed_cards)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
