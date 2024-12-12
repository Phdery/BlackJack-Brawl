class_name Card
extends Sprite2D

# Every card must has a score
@export var score:int
@export var description = "This is my description\nhi there"
@export var suit: String
@export var rank: String
signal mouse_entered
signal mouse_exited

#TODO make machanism for different cards
# based on special effect, set bool var to true when card created
# keep other bool var false
# when you call mechanism, only the correct effect will trigger
func mechanism(this:Controller, other:Controller):
	pass

#TODO some other helper function



# func for setting texture so that it's different for each card?
func set_card_texture() -> void:
	var suit_folder = ""
	match suit:
		GameGlobal.Suit.CLUBS:
			suit_folder = "clubs"
		GameGlobal.Suit.DIAMONDS:
			suit_folder = "diamonds"
		GameGlobal.Suit.HEARTS:
			suit_folder = "hearts"
		GameGlobal.Suit.SPADES:
			suit_folder = "spades"
		_:
			push_error("Unknown suit: %s" % suit)
			return

	var texture_path = "res://assets/card/%s/%s.png" % [suit_folder, rank]

	if ResourceLoader.exists(texture_path):
		var texture = load(texture_path)
		if texture:
			self.texture = texture
			print("Successfully set texture: %s" % texture_path)
		else:
			print("Fail to load texture: %s" % texture_path)
	else:
		print("Texture path not found: %s" % texture_path)


func _on_area_2d_mouse_entered() -> void:
	print(self.description)
	emit_signal("mouse_entered")	
 


func _on_area_2d_mouse_exited() -> void:
	print("leaving " + self.description)
	emit_signal("mouse_exited")
	
