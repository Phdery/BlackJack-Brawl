class_name CardDeck

extends Node2D

var cards:Array[Card]

#TODO function to generate random card
func generate_random_card() -> Card:
	return Card.new()


#TODO function to add card to the card list
func add_card(card: Card) -> void:
	pass
	
#TODO function to move card from one carddeck to the other
func move_card_to(card:Card, card_deck:CardDeck) -> void:
	pass

#TODO some other helper function
