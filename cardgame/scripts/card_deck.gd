class_name CardDeck
extends Node2D


signal clicked
@export var display:bool
@export var deckContents:PackedScene
var cards:Array[Card]
var deck_contents:DeckContents


func custom_init(is_display:bool):
	display = is_display
	deck_contents = deckContents.instantiate() as DeckContents


func _ready():
	pass


# draws a card from a random spot in the deck
func generate_random_card() -> Card:
	randomize()
	if cards.size() != 0:
		var random = randi() % cards.size()
		var return_card = cards[random]
		return return_card
	else: # no cards left in deck
		return null


#TODO function to add card to the card list
# Never call this externally!!!
func add_card(card: Card) -> void:
	cards.append(card)


# function to move card from one carddeck to the other
# use for after you draw a card from your deck
# removes card from previous carddeck
func move_card_to(card:Card, card_deck:CardDeck) -> void:
	card_deck.add_card(card)
	cards.erase(card)


# func that swaps two deck's contents
# use for when main deck runs out of cards 
# repopulate it with cards from graveyard deck
func swap_decks(card_deck:CardDeck) -> void:
	var temp_cards_1:Array[Card] = cards
	var temp_cards_2:Array[Card] = card_deck.cards
	cards = temp_cards_2
	card_deck.cards = temp_cards_1


func is_empty() -> bool:
	if cards.size() == 0:
		return true
	else:
		return false


func clear() -> void:
	cards.clear()


# when a deck is clicked, load the scene that displays its contents
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("clicked")
			add_child(deck_contents)
			deck_contents.display_cards()
	

func _to_string() -> String:
	var ret: String
	ret = str("Length: " , len(cards), "\n")
	return ret


func _process(delta: float) -> void:
	# for empty decks, display w/o texture
	if cards.is_empty():
		self.texture = null
	# for decks that aren't empty, display w/ card back texture
	else:
		if display == false:
			self.texture = load("res://assets/cards/carb_back_1.png")
