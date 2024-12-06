class_name Table
extends Control

@onready var player:Player = $Player
@onready var enemy:Enemy = $Enemy

#TODO Build Main Logic
var player_turn: bool = false

#TODO 2 different enemy scenes?
var enemies = [preload("res://scenes/enemy.tscn"), preload("res://scenes/enemy.tscn")]
var current_enemy: int = 0

func _ready():
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
	if player_turn:
		player.draw_and_execute_card()
		if !enemy.is_stopped:
			player_turn = false
			enemy_turn()

func _on_stand_button_pressed() -> void:
	if player_turn:
		if !enemy.is_stopped:
			player_turn = false
			enemy_turn()
		else:
			check_winner()

func _player_win():
	print("Enemy defeated!")
	#TODO beat enemy animation
	current_enemy += 1
	if enemies[current_enemy] != null:
		load_enemy(enemies[current_enemy])
		_start_round()
	else:
		print("Player defeated all enemies! Victory!")
		#TODO victory scene
	
func _enemy_win():
	print("Player lost!")
	#TODO player lose scene

func check_winner() -> void:
	var player_score = calculate_score(player.player_displayed_cards.cards)
	var enemy_score = calculate_score(enemy.enemy_displayed_cards.cards)
	var score_difference = player_score - enemy_score
	# same score or both bust
	if score_difference == 0 or player_score > 21 and enemy_score > 21:
		#TODO: tie animation
		pass
	# only enemy bust
	elif enemy_score > 21:
		#TODO: player win animation
		enemy.modify_health(-player_score)
	# only player bust
	elif player_score > 21:
		#TODO: enemy win animation
		player.modify_health(-enemy_score)
	# both didn't bust
	else:
		# player win
		if score_difference > 0:
			#TODO: player win animation
			enemy.modify_health(-score_difference)
		# enemy win
		else:
			#TODO: enemy win animation
			player.modify_health(-score_difference)
	# check signals
	enemy.enemy_died.connect(_player_win)
	player.player_died.connect(_enemy_win)
	
func calculate_score(hand: Array) -> int:
	var score: int = 0
	# Calculate the total score logic
	for card in hand:
		score += card.score
	#TODO ace logic here?
	return score

func enemy_turn():
	while !player_turn and !enemy.is_stopped:
		#TODO enemy logic
		#enemy.decide_action()
		if !player.is_stopped:
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
