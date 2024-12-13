class_name Controller

extends Node

#Parent class for player and enemy

@export var score_card: ScoreCard = null
@export var status_card: StatusCard = null
@export var displayed_cards: CardDeck = null
@export var card_deck: CardDeck = null
@export var used_card_deck: CardDeck = null
@export var is_stopped: bool = false  
@export var extra_points:int = 0

func start_move_card_animation(card:Card, _from_card_deck: CardDeck, _to_card_deck:CardDeck) -> void:
	pass
