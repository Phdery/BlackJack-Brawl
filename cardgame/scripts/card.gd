class_name Card
extends Sprite2D


@export var score:int
@export var description = "This is my description\nhi there"
@export var suit: String
@export var rank: String


signal mouse_entered
signal mouse_exited


# function for the special effect of special cards
func mechanism(this:Controller, other:Controller):
	pass


# func for setting texture so that it's different for each card
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
	#self.scale = Vector2(1.0001, 1.0001)
	#self.z_index += 1
	emit_signal("mouse_entered")	
 

func _on_area_2d_mouse_exited() -> void:
	print("leaving " + self.description)
	#self.scale = Vector2(0.7, 0.7)
	#self.z_index -= 1
	emit_signal("mouse_exited")
	
