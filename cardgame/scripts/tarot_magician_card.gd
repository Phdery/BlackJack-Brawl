class_name TarotMagicianCard
extends Card


# Called when the node enters the scene tree for the first time.
func init() -> void:
	score = 10
	description = "The Magician \n Score = 10\n take a random card from enemy's hand. "


func mechanism(this:Controller, other:Controller):
	var card = other.displayed_cards.generate_random_card()
	if card:
		other.displayed_cards.move_card_to(card, this.displayed_cards)
		this.displayed_cards.move_card_to(self, other.displayed_cards)
		other.displayed_cards.texture = load("res://assets/cards/magician.png")
		card.mechanism(this, other)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
