extends Node2D


var skipped = false

@onready var label: Label = $TextLabel
@onready var label2: Label = $TextLabel2
@onready var label3: Label = $TextLabel3
@onready var label4: Label = $TextLabel4
@onready var suit_special: Label = $SuitSpecial
@onready var game_intro: RichTextLabel = $GameIntro

@onready var diamond: Button = $CardSuit/DiamondSuit
@onready var club: Button = $CardSuit/ClubSuit
@onready var heart: Button = $CardSuit/HeartSuit
@onready var spade: Button = $CardSuit/SpadeSuit
@onready var skip: Button = $Skip

@onready var player = preload("res://scenes/player.tscn")
@onready var table = preload("res://scenes/table.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	diamond.hide()
	club.hide()
	heart.hide()
	spade.hide()
	label3.hide()
	label4.hide()
	suit_special.hide()
	
	label.text = "Congratulations, now you successfully"
	label2.text = "registered Gaming Playing course"
	
	var delay: float = 3.0
	SoundManager.stop_start()
	await get_tree().create_timer(delay).timeout
	SoundManager.play_sfx("StoryAudio")
	
	var audio_stream = "res://assets/sfx/background_story.mp3"
	
	## You can skip the introduction bu press Tab
	#var duration: float = 31.0
	#var timer = get_tree().create_timer(duration)
	#
	#if not skipped:
		#await timer.timeout
		#skip.hide()
	#else:
		#SoundManager.stop_story()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Chaneg texture and play animation of the button
func _on_diamond_suit_mouse_entered() -> void:
	SoundManager.play_sfx("ButtonFocus")
	suit_special.text = "  When you win as 21, heal 21"
	suit_special.show()
	label4.text = "Diamond"
	var animation := create_tween()
	animation.tween_property($CardSuit/DiamondSuit, "scale", Vector2(0.5, 0.5), 0.1)
	await animation.finished


# Chaneg texture and play animation of the button
func _on_diamond_suit_mouse_exited() -> void:
	var animation := create_tween()
	animation.tween_property($CardSuit/DiamondSuit, "scale", Vector2(0.4, 0.4), 0.1)
	await animation.finished


# Chaneg texture and play animation of the button
func _on_diamond_suit_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
	GameGlobal.chosen_suit = GameGlobal.Suit.DIAMONDS
	get_tree().change_scene_to_file("res://scenes/table.tscn")


# Chaneg texture and play animation of the button
func _on_club_suit_mouse_entered() -> void:
	SoundManager.play_sfx("ButtonFocus")
	label4.text = "Club"
	suit_special.text = "  Deal 1.5 damage when you win"
	suit_special.show()
	var animation := create_tween()
	animation.tween_property($CardSuit/ClubSuit, "scale", Vector2(0.5, 0.5), 0.1)
	await animation.finished


# Chaneg texture and play animation of the button
func _on_club_suit_mouse_exited() -> void:
	var animation := create_tween()
	animation.tween_property($CardSuit/ClubSuit, "scale", Vector2(0.4, 0.4), 0.1)
	await animation.finished


# Chaneg texture and play animation of the button
func _on_club_suit_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
	GameGlobal.chosen_suit = GameGlobal.Suit.CLUBS
	get_tree().change_scene_to_file("res://scenes/table.tscn")


# Chaneg texture and play animation of the button
func _on_heart_suit_mouse_entered() -> void:
	SoundManager.play_sfx("ButtonFocus")
	label4.text = "Heart"
	suit_special.text = "  Heal half of the damage you deal when you win"
	suit_special.show()
	var animation := create_tween()
	animation.tween_property($CardSuit/HeartSuit, "scale", Vector2(0.5, 0.5), 0.1)
	await animation.finished


# Chaneg texture and play animation of the button
func _on_heart_suit_mouse_exited() -> void:
	var animation := create_tween()
	animation.tween_property($CardSuit/HeartSuit, "scale", Vector2(0.4, 0.4), 0.1)
	await animation.finished


# Chaneg texture and play animation of the button
func _on_heart_suit_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
	GameGlobal.chosen_suit = GameGlobal.Suit.HEARTS
	get_tree().change_scene_to_file("res://scenes/table.tscn")


# Chaneg texture and play animation of the button
func _on_spade_suit_mouse_entered() -> void:
	SoundManager.play_sfx("ButtonFocus")
	label4.text = "Spade"
	suit_special.text = "  When you win as 21, deal double damage"
	suit_special.show()
	var animation := create_tween()
	animation.tween_property($CardSuit/SpadeSuit, "scale", Vector2(0.5, 0.5), 0.1)
	await animation.finished


# Chaneg texture and play animation of the button
func _on_spade_suit_mouse_exited() -> void:
	var animation := create_tween()
	animation.tween_property($CardSuit/SpadeSuit, "scale", Vector2(0.4, 0.4), 0.1)
	await animation.finished


# Chaneg texture and play animation of the button
func _on_spade_suit_pressed() -> void:
	SoundManager.play_sfx("ButtonStart")
	GameGlobal.chosen_suit = GameGlobal.Suit.SPADES
	get_tree().change_scene_to_file("res://scenes/table.tscn")


# Skip the intro and the story to start the game
func _on_skip_pressed() -> void:
	skipped = true
	skip.hide()
	SoundManager.stop_story()
	SoundManager.play_sfx("InGameBGM")

	
	label.hide()
	label2.hide()
	game_intro.hide()
	label3.show()
	label4.text = ""
	label4.show()
	
	var gap: float = 0.5
	await get_tree().create_timer(gap).timeout
	diamond.show()
	await get_tree().create_timer(gap).timeout
	club.show()
	await get_tree().create_timer(gap).timeout
	heart.show()
	await get_tree().create_timer(gap).timeout
	spade.show()
