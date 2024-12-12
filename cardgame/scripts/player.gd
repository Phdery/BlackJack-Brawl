class_name Player
extends Controller 



# Enum for card suits
const Suit = GameGlobal.Suit
var suit: Suit

var is_stopped: bool = false  # Tracks if the player's turn is stopped

func _ready() -> void:
	score_card = $VBoxContainer/CenterContainer/PlayerScoreCard
	status_card = $VBoxContainer/CenterContainer/PlayerStatusCard
	displayed_cards = $VBoxContainer/CenterContainer2/PlayerDisplayedCardDeck
	card_deck = $VBoxContainer/CenterContainer2/PlayerCardDeck
	used_card_deck = $VBoxContainer/CenterContainer2/PlayerUsedCardDeck
	
	modify_health(100.0)
	suit = GameGlobal.chosen_suit
	var suit_string: String = ""
	suit_string = GameGlobal.suit_string(suit)
	initialize_deck(suit_string)
	
# Initializes the player's deck based on the chosen suit
func initialize_deck(suit: String) -> void:
	
	var scores = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
	var card_resource = preload("res://scenes/basic_card.tscn")
	
	for score in scores:
		var new_card = card_resource.instantiate() as BasicCard
		new_card.custom_init(score, suit)
		card_deck.add_card(new_card)

	shuffle(card_deck.cards)

# Modifies the player's health (damage or heal) and updates the status card
func modify_health(amount: int) -> void:
	status_card.update_hp(clamp(status_card.current_hp + amount, 0, status_card.max_hp))
	if status_card.current_hp <= 0:
		_on_player_death()

# Handles the player's death
func _on_player_death() -> void:
	is_stopped = true
	emit_signal("player_died")

# Moves all cards from the used deck back to the main card deck when it's empty
func refill_card_deck() -> void:
	if card_deck.is_empty():
		for card in used_card_deck.cards:
			card_deck.add_card(card)
		used_card_deck.clear()
		shuffle(card_deck.cards)

# Draws a random card from the player's card deck
func generate_random_card() -> BasicCard:
	if card_deck.cards.size() == 0:
		return null  # Return null if no cards are left in the deck
		
	# Generate a random index within the range of available cards
	var random_index = randi() % card_deck.cards.size()

	# Get the card at the random index
	var random_card = card_deck.cards[random_index]

	# Remove the card from the deck to ensure it isn't drawn again
	card_deck.cards.erase(random_card)

	return random_card  # Return the selected card

# Draws a random card from the deck, moves it to the displayed deck, and executes its mechanism
func draw_and_execute_card() -> void:
	if card_deck.is_empty():
		refill_card_deck()
	
	var drawn_card = card_deck.generate_random_card()
	if drawn_card:
		displayed_cards.add_card(drawn_card)
		execute_card_mechanism(drawn_card)

# Executes the mechanism of the drawn card
func execute_card_mechanism(card: Card) -> void:
	card.mechanism(self, null)  # Replace null with a target controller if needed

# Updates scores for both player and enemy at the end of a turn
func update_scores() -> void:
	# Set player's score and max_score to default
	score_card.update_score(0)
	score_card.update_max(21)

func move_displayed_cards_to_used() -> void:
	# Move player's displayed cards to used deck
	for card in displayed_cards.cards:
		card.move_card_to(card, used_card_deck)
		
# Returns whether the player has stopped (for turn management)
func has_stopped() -> bool:
	return is_stopped

# Stops the player's turn
func stop_turn() -> void:
	is_stopped = true

# Resets the player's turn state
func reset_turn() -> void:
	is_stopped = false

func shuffle(deck: Array) -> void:
	for i in range(deck.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		# Perform the swap using a temporary variable
		var temp = deck[i]
		deck[i] = deck[j]
		deck[j] = temp

# Signal emitted when the player dies
signal player_died

func move_card_animation(card:Card, from_card_deck: CardDeck, to_card_deck:CardDeck, delta) -> void:
	var move_thing:Sprite2D = Sprite2D.new()
	move_thing.texture = card.texture
	from_card_deck.add_child(move_thing)
