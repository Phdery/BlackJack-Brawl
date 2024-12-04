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
# Takes damage or heals the enemy
func modify_health(amount: int) -> void:
	enemy_status_card.health += amount
	if enemy_status_card.health > enemy_status_card.max_health:
		enemy_status_card.health = enemy_status_card.max_health
	elif enemy_status_card.health <= 0:
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
	card.apply_effect(self)

### Enemy Behavior
# Makes a decision based on aggression level
func decide_action(player: Player) -> void:
	match aggression_level:
		1: # Cautious
			if enemy_status_card.health < enemy_status_card.max_health / 2:
				draw_and_execute_card()  # Use a card to heal or defend
			else:
				stop_turn()
		2: # Balanced
			if randi() % 2 == 0:
				draw_and_execute_card()
			else:
				stop_turn()
		3: # Aggressive
			draw_and_execute_card()

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

### Signals
signal enemy_died
signal enemy_turn_ended
