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

func suit_string(suit: Suit) -> String:
	var suit_string = ""
	match suit:
		GameGlobal.Suit.CLUBS:
			suit_string = "clubs"
		GameGlobal.Suit.DIAMONDS:
			suit_string = "diamonds"
		GameGlobal.Suit.HEARTS:
			suit_string = "hearts"
		GameGlobal.Suit.SPADES:
			suit_string = "spades"
		_:
			print("Unknown suit: %s" % suit)
			return ""
	return suit_string
