class_name CardDeck

extends Node2D

var cards:Array[Card]
var display:bool = false
signal clicked
@export var deckContents:PackedScene
var deck_contents:DeckContents

func custom_init(is_display:bool):
	display = is_display
	if display:
		self.texture = null
	else:
		self.texture = load("res://assets/cards/carb_back_1.png")
	deck_contents = deckContents.instantiate() as DeckContents



func _ready():
	custom_init(false)
	

#TODO function to generate random card
# draws a card from a random spot in the deck
# deletes that card from the deck?
func generate_random_card() -> Card:
	randomize()
	var random = randi() % cards.size()
	var return_card = cards[random]
	# cards.remove_at(random)
	return return_card


#TODO function to add card to the card list
func add_card(card: Card) -> void:
	cards.append(card)
	if display:
		self.texture = card.texture
	
	
#TODO function to move card from one carddeck to the other
# use for after you draw a card from your deck?
# assume card already removed from previous carddeck?
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
# func that displays deck's contents when clicked?
# func that sets deck's texture? or just set elsewhere?
# func that displays cards at play in center of screen?

func is_empty() -> bool:
	if cards.size() == 0:
		return true
	else:
		return false

func clear() -> void:
	cards.clear()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print("clicked")
		$".".add_child(deck_contents)
		deck_contents.display_cards()
		# make current scene invisble
		# call display cards function in deckcontents scene, pass in cards array
