extends Node

signal player_win
signal player_fail


enum Suit { 
	HEARTS, 
	DIAMONDS, 
	CLUBS, 
	SPADES 
}


enum GameState {
	UNKNOWN,
	PLAYER_WIN,
	PLAYER_FAIL
}


var chosen_suit: Suit = Suit.HEARTS
var game_state = GameState.UNKNOWN
@onready var player_card_deck: CardDeck = $PlayerCardDeck


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
			suit_string = "club"
		GameGlobal.Suit.DIAMONDS:
			suit_string = "diamond"
		GameGlobal.Suit.HEARTS:
			suit_string = "heart"
		GameGlobal.Suit.SPADES:
			suit_string = "spade"
		_:
			print("Unknown suit: %s" % suit)
			return ""
	return suit_string
