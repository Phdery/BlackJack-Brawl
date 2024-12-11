class_name BasicCard
extends Card

var deck_contents_scene = preload("res://scenes/deck_contents.tscn")



func custom_init(new_score:int, new_suit:String) -> void:
	score = new_score
	suit = new_suit
	var texture_path:String = "res://assets/cards/" + suit + "/" + suit + "_" + str(score) + ".png"
	self.texture = load(texture_path)
	description = str(score) + " of " + suit

func update_texture() -> void:
	var texture_path:String = "res://assets/cards/" + suit + "/" + suit + "_" + str(score) + ".png"
	self.texture = load(texture_path)
	
	
	
