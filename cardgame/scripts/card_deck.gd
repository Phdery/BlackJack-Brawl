class_name CardDeck
extends Node2D


var cards:Array[Card]
var display_deck:bool


func _init(new_cards:Array[Card], display:bool) -> void:
	cards = new_cards
	display_deck = display
	if cards.size() > 0: # set texture to back of card
		pass
	else: # no texture if deck is empty
		self.texture = null

#TODO function to generate random card
# draws a card from a random spot in the deck
func generate_random_card() -> Card:
	randomize()
	var random:int = randi() % cards.size()
	var return_card:Card = cards[random]
	return return_card


#TODO function to add card to the card list
func add_card(card: Card) -> void:
	cards.append(card)
	# if display deck, change texture to most recent card
	if display_deck:
		self.texture = card.texture
	else: # set texture to back of card
		pass
	
#TODO function to move card from one carddeck to the other
# use for after you draw a card from your deck
# erases card from previous deck
func move_card_to(card:Card, card_deck:CardDeck) -> void:
	card_deck.add_card(card)
	cards.erase(card)
	
# func that swaps two deck's contents
# use for when main deck runs out of cards and you want to repurpose graveyard deck
# or could be used as some card's special effect idk
func swap_decks(card_deck:CardDeck) -> void:
	var temp_cards_1:Array[Card] = cards
	var temp_cards_2:Array[Card] = card_deck.cards
	cards = temp_cards_2
	card_deck.cards = temp_cards_1

#TODO some other helper function
