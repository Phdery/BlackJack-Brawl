class_name BasicCard
extends Card

	
func _init(new_score:int, new_suit:String) -> void:
	score = new_score
	suit = new_suit
	var texture_path:String = "res://assets/cards/" + suit + "/" + suit + "_" + str(score) + ".png"
	self.texture = load(texture_path)


	
