class_name Table
extends Control

@onready var player:Player = $MainLayout/PlayerBox/Player
@onready var enemy:Enemy = $MainLayout/EnemyBox/Enemy

var _have_ace: bool = false
var player_turn: bool = false
var player_score: int
var enemy_score: int

#TODO maybe have 2 different enemy scenes?
var enemies = [preload("res://scenes/enemy.tscn")]
var current_enemy: int = 0

signal player_win
signal player_fail

func _ready():
	var player_box: CenterContainer = $MainLayout/PlayerBox
	# load first enemy
	load_enemy(enemies[current_enemy])
	# initialize and start
	_start_round()

func _start_round():
	player.refill_card_deck()
	enemy.refill_card_deck()
	player_turn = true
	enemy.draw_and_execute_card()

func _on_hit_button_pressed() -> void:
	player_score = calculate_score(player.player_displayed_cards.cards, player.player_score_card.max_score)
	if player_turn and player_score < player.player_score_card.max_score:
		player.draw_and_execute_card()
		if !enemy.is_stopped:
			player_turn = false
			enemy_turn()

func _on_stand_button_pressed() -> void:
	player_score = calculate_score(player.player_displayed_cards.cards, player.player_score_card.max_score)
	#TODO: need to get max score
	if player_turn and player_score < player.player_score_card.max_score:
		if !enemy.is_stopped:
			player_turn = false
			enemy_turn()
		else:
			check_winner()

func _player_win():
	print("Enemy defeated!")
	SoundManager.play_sfx("game_win")
	#TODO beat enemy animation
	current_enemy += 1
	if enemies[current_enemy] != null:
		load_enemy(enemies[current_enemy])
		_start_round()
	else:
		print("Player defeated all enemies! Victory!")
		player_win.emit()
		#TODO victory scene
	
func _enemy_win():
	print("Player lost!")
	SoundManager.play_sfx("game_fail")
	player_fail.emit()
	#TODO player lose scene

func check_winner() -> void:
	player_score = calculate_score(player.player_displayed_cards.cards, player.player_score_card.max_score)
	enemy_score = calculate_score(enemy.enemy_displayed_cards.cards, 21)
	var score_difference = player_score - enemy_score
	var damage: int
	var player_win: bool
	# same score or both bust
	if score_difference == 0 or (player_score > player.player_score_card.max_score and enemy_score > 21):
		#TODO: tie animation
		pass
	# only enemy bust
	elif enemy_score > 21:
		#TODO: player win animation
		player_win = true
		damage = suit_execute(player_score, player_win, player_score)
		enemy.modify_health(-damage)
	# only player bust
	elif player_score > player.player_score_card.max_score:
		#TODO: enemy win animation
		player_win = false
		damage = suit_execute(enemy_score, player_win, player_score)
		player.modify_health(-damage)
	# both didn't bust
	else:
		# player win
		if score_difference > 0:
			#TODO: player win animation
			#TODO: suit effect
			player_win = true
			damage = suit_execute(score_difference, player_win, player_score)
			enemy.modify_health(-damage)
		# enemy win
		else:
			#TODO: enemy win animation
			player_win = false
			damage = suit_execute(score_difference, player_win, player_score)
			player.modify_health(-damage)
	# check signals
	enemy.enemy_died.connect(_player_win)
	player.player_died.connect(_enemy_win)
	# reset turn
	player.reset_turn()
	enemy.reset_turn()
	
func calculate_score(hand: Array, max_score: int) -> int:
	var score: int = 0
	# Calculate the total score logic
	for card in hand:
		score += card.score
		if card.score == 11:
			_have_ace = true
	# Ace logic
	if _have_ace and score > max_score:
		score -= 10
	return score

func enemy_turn():
	while !player_turn and !enemy.is_stopped:
		#TODO enemy logic
		enemy.make_decision_based_on_probability()
		enemy_score = calculate_score(enemy.enemy_displayed_cards.cards, 21)
		if !player.is_stopped or enemy_score > 21:
			player_turn = true
	if player.is_stopped and enemy.is_stopped:
		check_winner()


# multiple enemy logic
func load_enemy(enemy_scene: PackedScene) -> void:
	# clear UI for next enemy
	if enemy != null:
		enemy.queue_free()  # free old enemy
	enemy = enemy_scene.instantiate()
	add_child(enemy) # add new enemy
	
func suit_execute(damage: int, player_win: bool, score: int) -> int:
	var suit = GameGlobal.chosen_suit
	var new_damage: int
	match suit:
		GameGlobal.Suit.CLUBS:
			if player_win:
				new_damage = damage * 1.5
			else:
				new_damage = damage
		GameGlobal.Suit.DIAMONDS:
			if player_win and score == player.player_score_card.max_score:
				new_damage = player.player_score_card.max_score
				player.modify_health(player.player_score_card.max_score)
			else:
				new_damage = damage
		GameGlobal.Suit.HEARTS:
			if player_win:
				player.modify_health(damage/2)
			new_damage = damage
		GameGlobal.Suit.SPADES:
			if player_win and score == player.player_score_card.max_score:
				new_damage = damage * 2
			else:
				new_damage = damage
	return new_damage
