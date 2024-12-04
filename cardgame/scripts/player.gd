class_name Player

extends Controller

@onready var player_score_card: ScoreCard = $PlayerScoreCard
@onready var player_status_card: StatusCard = $PlayerStatusCard
@onready var player_displayed_cards: CardDeck = $PlayerDisplayedCardDeck
@onready var player_card_deck: CardDeck = $PlayerCardDeck
@onready var player_used_card_deck: CardDeck = $PlayerUsedCardDeck

# Enum for card suits
enum Suit { HEARTS, DIAMONDS, CLUBS, SPADES }
var suit: Suit

var is_stopped: bool = false

### Health and Damage Management
# Takes damage or heals the player
func modify_health(amount: int) -> void:
	# Negative amount = damage, Positive amount = heal
	player_status_card.health += amount
	if player_status_card.health > player_status_card.max_health:
		player_status_card.health = player_status_card.max_health
	elif player_status_card.health <= 0:
		_on_player_death()

# Handles player's death
func _on_player_death() -> void:
	is_stopped = true
	emit_signal("player_died") # Signal to notify other systems of death

### Deck Management
# Move all cards from the used deck back to the main card deck when it's empty
func refill_card_deck() -> void:
	if player_card_deck.is_empty():
		for card in player_used_card_deck.cards:
			player_card_deck.add_card(card)
		player_used_card_deck.clear()
		player_card_deck.shuffle()

# Randomly draw a card from the deck, move to the displayed deck, and execute its mechanism
func draw_and_execute_card() -> void:
	if player_card_deck.is_empty():
		refill_card_deck()
	
	var drawn_card = player_card_deck.draw_card()
	if drawn_card:
		player_displayed_cards.add_card(drawn_card)
		execute_card_mechanism(drawn_card)

# Execute a card's specific effect
func execute_card_mechanism(card: Card) -> void:
	card.apply_effect(self)

### Helper Functions
# Returns whether the player has stopped (for turn management)
func has_stopped() -> bool:
	return is_stopped

# Stop player's turn
func stop_turn() -> void:
	is_stopped = true

# Reset the player's turn state
func reset_turn() -> void:
	is_stopped = false

# Shuffle the player's deck
func shuffle_deck() -> void:
	player_card_deck.shuffle()

### Signals
signal player_died
