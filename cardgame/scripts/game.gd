extends Node

@onready var player_card_deck: CardDeck = $PlayerCardDeck
enum Suit { HEARTS, DIAMONDS, CLUBS, SPADES }
var chosen_suit: Suit = Suit.HEARTS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
