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
var score_card = preload("res://scenes/score_card.tscn").instantiate()

signal player_win
signal player_fail

func _ready():
	print("ScoreCard Instance Type: ", score_card)
	print("ScoreCard Instance Children: ", score_card.get_children())
	var player_box: CenterContainer = $MainLayout/PlayerBox
	player_box.add_child(score_card)
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
	player_score = calculate_score(player.player_displayed_cards.cards, player.max_score())
	if player_turn and player_score < 21:
		player.draw_and_execute_card()
		if !enemy.is_stopped:
			player_turn = false
			enemy_turn()

func _on_stand_button_pressed() -> void:
	player_score = calculate_score(player.player_displayed_cards.cards, player.max_score())
	#TODO: need to get max score
	if player_turn and player_score < player.max_score():
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
	player_score = calculate_score(player.player_displayed_cards.cards, player.max_score())
	enemy_score = calculate_score(enemy.enemy_displayed_cards.cards, 21)
	var score_difference = player_score - enemy_score
	# same score or both bust
	if score_difference == 0 or (player_score > player.max_score() and enemy_score > 21):
		#TODO: tie animation
		pass
	# only enemy bust
	elif enemy_score > 21:
		#TODO: player win animation
		#TODO: suit effect
		enemy.modify_health(-player_score)
	# only player bust
	elif player_score > player.max_score():
		#TODO: enemy win animation
		player.modify_health(-enemy_score)
	# both didn't bust
	else:
		# player win
		if score_difference > 0:
			#TODO: player win animation
			#TODO: suit effect
			enemy.modify_health(-score_difference)
		# enemy win
		else:
			#TODO: enemy win animation
			player.modify_health(-score_difference)
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
		enemy.make_decision_based_on_probabilty()
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
