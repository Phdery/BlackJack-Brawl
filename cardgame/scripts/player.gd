class_name Player
extends Controller

@onready var player_score_card: ScoreCard = $PlayerScoreCard
@onready var player_status_card: StatusCard = $PlayerStatusCard
@onready var player_displayed_cards: CardDeck = $PlayerDisplayedCardDeck
@onready var player_card_deck: CardDeck = $PlayerCardDeck
@onready var player_used_card_deck: CardDeck = $PlayerUsedCardDeck

# Enum for card suits
const Suit = GameGlobal.Suit
var suit: Suit

var is_stopped: bool = false  # Tracks if the player's turn is stopped
var score_card = preload("res://scenes/score_card.tscn").instantiate()
var basic_card = preload("res://scenes/basic_card.tscn")

# Initializes the player's deck based on the chosen suit
func initialize_deck(suit: String) -> void:
	
	var scores = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
	var card_resource = preload("res://scenes/basic_card.tscn")
	
	for score in scores:
		var new_card = card_resource.instantiate() as BasicCard
		new_card.custom_init(score, suit)
		player_card_deck.add_card(new_card)
	
	player_card_deck.shuffle()

func _ready() -> void:
	modify_health(100.0)
	suit = GameGlobal.chosen_suit
	var suit_string: String = ""
	suit_string = GameGlobal.suit_string(suit)
	initialize_deck(suit_string)

# Modifies the player's health (damage or heal) and updates the status card
func modify_health(amount: int) -> void:
	player_status_card.update_hp(clamp(player_status_card.current_hp + amount, 0, player_status_card.max_hp))
	if player_status_card.current_hp <= 0:
		_on_player_death()

# Handles the player's death
func _on_player_death() -> void:
	is_stopped = true
	emit_signal("player_died")

# Moves all cards from the used deck back to the main card deck when it's empty
func refill_card_deck() -> void:
	if player_card_deck.is_empty():
		for card in player_used_card_deck.cards:
			player_card_deck.add_card(card)
		player_used_card_deck.clear()
		player_card_deck.shuffle()

# Draws a random card from the deck, moves it to the displayed deck, and executes its mechanism
func draw_and_execute_card() -> void:
	if player_card_deck.is_empty():
		refill_card_deck()
	
	var drawn_card = player_card_deck.draw_card()
	if drawn_card:
		player_displayed_cards.add_card(drawn_card)
		execute_card_mechanism(drawn_card)

# Executes the mechanism of the drawn card
func execute_card_mechanism(card: Card) -> void:
	card.mechanism(self, null)  # Replace null with a target controller if needed

# Updates scores for both player and enemy at the end of a turn
func update_scores() -> void:
	# Set player's score and max_score to default
	player_score_card.update_score(0)
	player_score_card.update_max(21)

func move_displayed_cards_to_used() -> void:
	# Move player's displayed cards to used deck
	for card in player_displayed_cards.cards:
		card.move_card_to(card, player_used_card_deck)
		
# Returns whether the player has stopped (for turn management)
func has_stopped() -> bool:
	return is_stopped

# Stops the player's turn
func stop_turn() -> void:
	is_stopped = true

# Resets the player's turn state
func reset_turn() -> void:
	is_stopped = false

# Shuffles the player's deck
func shuffle_deck() -> void:
	player_card_deck.shuffle()

func shuffle(deck: Array) -> void:
	for i in range(deck.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		# Perform the swap using a temporary variable
		var temp = deck[i]
		deck[i] = deck[j]
		deck[j] = temp

# Signal emitted when the player dies
signal player_died
