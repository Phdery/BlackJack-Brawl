class_name Player

extends Controller

@onready var player_score_card:ScoreCard = $PlayerScoreCard
@onready var player_status_card:StatusCard = $PlayerStatusCard
@onready var player_displayed_cards:CardDeck = $PlayerDisplayedCardDeck
@onready var player_card_deck:CardDeck = $PlayerCardDeck
@onready var player_used_card_deck:CardDeck = $PlayerUsedCardDeck

# TODO make a enums for the suit
var suit

var is_stopped:bool

#TODO function for take damage/heal (could be seperate function or just one function)

#TODO function to move the card from usedDeck to cardDeck when cardDeck is empty

#TODO function to randomlly move a card from cardDeck to displayCardDeck and execute the card's mechanism

#TODO some other helper function
