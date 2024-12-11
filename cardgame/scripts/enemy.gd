class_name Enemy

extends Controller

@onready var enemy_score_card: ScoreCard = $EnemyScoreCard
@onready var enemy_status_card: StatusCard = $EnemyStatusCard
@onready var enemy_displayed_cards: CardDeck = $EnemyDisplayedCardDeck
@onready var enemy_card_deck: CardDeck = $EnemyCardDeck
@onready var enemy_used_card_deck: CardDeck = $EnemyUsedCardDeck

# Enemy-specific behavior variables
var is_stopped: bool = false
var aggression_level: int = 1  # Determines the enemy's strategy (1 = cautious, 2 = balanced, 3 = aggressive)

### Health and Damage Management
# Takes damage or heals the enemy and updates the status card
func modify_health(amount: int) -> void:
	enemy_status_card.update_hp(clamp(enemy_status_card.current_hp + amount, 0, enemy_status_card.max_hp))
	if enemy_status_card.current_hp <= 0:
		_on_enemy_death()

# Handles enemy's death
func _on_enemy_death() -> void:
	is_stopped = true
	emit_signal("enemy_died")  # Signal to notify other systems of death

### Deck Management
# Move all cards from the used deck back to the main card deck when it's empty
func refill_card_deck() -> void:
	if enemy_card_deck.is_empty():
		for card in enemy_used_card_deck.cards:
			enemy_card_deck.add_card(card)
		enemy_used_card_deck.clear()
		enemy_card_deck.shuffle()

# Randomly draw a card from the deck, move to the displayed deck, and execute its mechanism
func draw_and_execute_card() -> void:
	if enemy_card_deck.is_empty():
		refill_card_deck()
	
	var drawn_card = enemy_card_deck.draw_card()
	if drawn_card:
		enemy_displayed_cards.add_card(drawn_card)
		execute_card_mechanism(drawn_card)

# Execute a card's specific effect
func execute_card_mechanism(card: Card) -> void:
	card.mechanism(self, null)  # Replace null with the target controller if needed

### Enemy Behavior
# Makes a decision based on aggression level or probability
func decide_action(player: Player) -> void:
	if aggression_level == 1: # Cautious
		if enemy_status_card.current_hp < enemy_status_card.max_hp / 2:
			draw_and_execute_card()  # Use a card to heal or defend
		else:
			stop_turn()
	elif aggression_level == 2: # Balanced
		if randi() % 2 == 0:
			draw_and_execute_card()
		else:
			stop_turn()
	elif aggression_level == 3: # Aggressive
		draw_and_execute_card()
	elif aggression_level == 4: # Probability-based behavior
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
		stop_turn()  # Stop turn if the risk is too high

# Calculates the total value of the enemy's displayed cards
func calculate_hand_total() -> int:
	var total = 0
	for card in enemy_displayed_cards.cards:
		total += card.score  # Assuming card.score holds the card's value
	return total

func update_scores() -> void:
	# Set player's score and max_score to default
	enemy_score_card.update_score(0)
	enemy_score_card.update_max(21)

func move_displayed_cards_to_used() -> void:
	# Move player's displayed cards to used deck
	for card in enemy_displayed_cards.cards:
		card.move_card_to(card, enemy_used_card_deck)
		
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

# Shuffle the enemy's deck
func shuffle_deck() -> void:
	enemy_card_deck.shuffle()
	
func shuffle(deck: Array) -> void:
	for i in range(deck.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		# Perform the swap using a temporary variable
		var temp = deck[i]
		deck[i] = deck[j]
		deck[j] = temp

### Signals
signal enemy_died
signal enemy_turn_ended
