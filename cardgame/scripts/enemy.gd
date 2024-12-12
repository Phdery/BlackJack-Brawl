class_name Enemy

extends Controller

# Enemy-specific behavior variables
const Suit = GameGlobal.Suit
var suit: Suit
var is_stopped: bool = false  # Tracks if the enemy's turn is stopped
var from_card_deck:CardDeck
var to_card_deck:CardDeck

func _ready() -> void:
	score_card = $VBoxContainer/CenterContainer/EnemyScoreCard
	status_card = $VBoxContainer/CenterContainer/EnemyStatusCard
	displayed_cards = $VBoxContainer/CenterContainer2/EnemyDisplayedCardDeck2
	card_deck = $VBoxContainer/CenterContainer2/EnemyCardDeck2
	used_card_deck = $VBoxContainer/CenterContainer2/EnemyUsedCardDeck2
	displayed_cards.display = true
 
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
 
### Health and Damage Management
# Takes damage or heals the enemy and updates the status card
func modify_health(amount: int) -> void:
	status_card.update_hp(clamp(status_card.current_hp + amount, 0, status_card.max_hp))
	if status_card.current_hp <= 0:
		_on_enemy_death()

# Handles enemy's death
func _on_enemy_death() -> void:
	is_stopped = true
	emit_signal("enemy_died")  # Signal to notify other systems of death

### Deck Management
# Move all cards from the used deck back to the main card deck when it's empty
func refill_card_deck() -> void:
	if card_deck.is_empty():
		start_move_card_animation(used_card_deck.cards[0], used_card_deck, card_deck)
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

# Randomly draw a card from the deck, move to the displayed deck, and execute its mechanism
func draw_and_execute_card() -> void:
	if card_deck.is_empty():
		refill_card_deck()
 
	var drawn_card = card_deck.generate_random_card()
	if drawn_card:
		displayed_cards.add_card(drawn_card)
		start_move_card_animation(drawn_card, card_deck, displayed_cards)
		execute_card_mechanism(drawn_card)

# Execute a card's specific effect
func execute_card_mechanism(card: Card) -> void:
	card.mechanism(self, null)  # Replace null with the target controller if needed

### Enemy Behavior
# Makes a decision based on aggression level or probability
func decide_action() -> void:
	make_decision_based_on_probability()

# Makes a decision based on proximity to 21
func make_decision_based_on_probability() -> void:
	var current_total = calculate_hand_total()
	var target_value = 21
	var difference = target_value - current_total

	# Probability decreases as the enemy's total approaches 21
	# Example: If 21 - total = 5, then probability = 0.5 (50% chance)
	var probability = clamp(difference / 10.0, 0.0, 1.0)  # Scale down to 0-1 range

	if randf() < probability:
		draw_and_execute_card()  # Draw a card with a chance based on probability
	else:
		print("Enemy Stands.")
		stop_turn()  # Stop turn if the risk is too high

# Calculates the total value of the enemy's displayed cards
func calculate_hand_total() -> int:
	var total = 0
	for card in displayed_cards.cards:
		total += card.score  # Assuming card.score holds the card's value
	return total

func update_scores() -> void:
	# Set player's score and max_score to default
	score_card.update_score(0)
	score_card.update_max(21)

func move_displayed_cards_to_used() -> void:
	# Move player's displayed cards to used deck
	for card in displayed_cards.cards:
		card.move_card_to(card, used_card_deck)
  
# End the enemy's turn
func stop_turn() -> void:
	is_stopped = true
	emit_signal("enemy_turn_ended")

### Helper Functions
# Returns whether the enemy has stopped (for turn management)
func has_stopped() -> bool:
	return is_stopped

# Reset the enemy's turn state
func reset_turn() -> void:
	is_stopped = false
	move_displayed_cards_to_used()
	start_move_card_animation(displayed_cards.cards[len(displayed_cards.cards)-1], displayed_cards, used_card_deck)

func shuffle(deck: Array) -> void:
	for i in range(deck.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		# Perform the swap using a temporary variable
		var temp = deck[i]
		deck[i] = deck[j]
		deck[j] = temp

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
	if start_moving == true:
		move_card_animation(card_deck.cards[0], from_card_deck, to_card_deck, delta)
  
### Signals
signal enemy_died
signal enemy_turn_ended
