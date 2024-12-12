class_name Player
extends Controller 

# Enum for card suits
const Suit = GameGlobal.Suit
var suit: Suit
var is_stopped: bool = false  # Tracks if the player's turn is stopped
var from_card_deck:CardDeck
var to_card_deck:CardDeck

func _ready() -> void:
	score_card = $VBoxContainer/CenterContainer/PlayerScoreCard
	status_card = $VBoxContainer/CenterContainer/PlayerStatusCard
	displayed_cards = $VBoxContainer/CenterContainer2/PlayerDisplayedCardDeck
	card_deck = $VBoxContainer/CenterContainer2/PlayerCardDeck
	used_card_deck = $VBoxContainer/CenterContainer2/PlayerUsedCardDeck
	
	displayed_cards.custom_init(true)
	card_deck.custom_init(false)
	used_card_deck.custom_init(false)
	
	modify_health(100.0)
	suit = GameGlobal.chosen_suit
	var suit_string: String = ""
	suit_string = GameGlobal.suit_string(suit)
	print("Card suit chosen by the player: ", suit_string)
	initialize_deck(suit_string)
	
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
		start_move_card_animation(used_card_deck.cards[0], used_card_deck, card_deck)
		for card in used_card_deck.cards:
			used_card_deck.move_card_to(card, card_deck)
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
	
	var drawn_card = generate_random_card()
	if drawn_card:
		start_move_card_animation(drawn_card, card_deck, displayed_cards)
		card_deck.move_card_to(drawn_card, displayed_cards)
		print("Player card deck: ", card_deck.cards)
		
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
	while(displayed_cards.is_empty() == false):
		for card in displayed_cards.cards:
			displayed_cards.move_card_to(card, used_card_deck)
		
# Returns whether the player has stopped (for turn management)
func has_stopped() -> bool:
	return is_stopped

# Stops the player's turn
func stop_turn() -> void:
	is_stopped = true

# Resets the player's turn state
func reset_turn() -> void:
	is_stopped = false
	
	update_scores()
	start_move_card_animation(displayed_cards.cards[len(displayed_cards.cards)-1], displayed_cards, used_card_deck)
	move_displayed_cards_to_used()
	displayed_cards.texture = null

func shuffle(deck: Array) -> void:
	for i in range(deck.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		# Perform the swap using a temporary variable
		var temp = deck[i]
		deck[i] = deck[j]
		deck[j] = temp

# Signal emitted when the player dies
signal player_died

var move_thing:Sprite2D
var start_moving:bool = false

func start_move_card_animation(card:Card, _from_card_deck: CardDeck, _to_card_deck:CardDeck) -> void:
	from_card_deck = _from_card_deck
	to_card_deck = _to_card_deck
	move_thing = Sprite2D.new()
	move_thing.texture = card.texture
	move_thing.visible = true
	#move_thing.global_position = _from_card_deck.global_position
	move_thing.z_index = 99
	#add_child(move_thing)
	#move_thing.global_position = from_card_deck.global_position
	_from_card_deck.add_child(move_thing)
	
	start_moving = true

func move_card_animation(card:Card, from_card_deck: CardDeck, to_card_deck:CardDeck, delta) -> void:
	#print("Moving")
	var speed = 300
	#move_thing.move_to_front()
	#print(round(to_card_deck.global_position - move_thing.global_position))
	move_thing.global_position = move_thing.global_position.move_toward(to_card_deck.global_position, delta*speed)
	if round(to_card_deck.global_position - move_thing.global_position) == Vector2(0,0):
		print("Arrived")
		if to_card_deck == displayed_cards:
			displayed_cards.texture = displayed_cards.cards[len(displayed_cards.cards) - 1].texture
		start_moving = false
		move_thing.queue_free()
		from_card_deck = null
		to_card_deck = null
func _process(delta: float) -> void:
	#print(move_thing.global_position)
	if start_moving == true and !card_deck.cards.is_empty():
		move_card_animation(card_deck.cards[0], from_card_deck, to_card_deck, delta)
