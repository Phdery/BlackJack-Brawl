class_name BasicCard
extends Card


var deck_contents_scene = preload("res://scenes/deck_contents.tscn")


func custom_init(new_score:int, new_suit:String) -> void:
	var score_name:String
	
	match new_score:
		1:
			score_name = "ace"
			score = 11
		11:
			score_name = "j"
			score = 10
		12: 
			score_name = "q"
			score = 10
		13:
			score_name = "k"
			score = 10
		_: 
			score_name = str(new_score)
			score = new_score

	suit = new_suit
	var texture_path:String = "res://assets/cards/" + suit + "/" + suit + "_" + score_name + ".png"
	self.texture = load(texture_path)
	if new_score == 1:
		description = score_name + " of " + suit + "\n Score: 1/11"
	else:
		description = score_name + " of " + suit + "\n Score: " + str(score)

#func update_texture() -> void:
	#var texture_path:String = "res://assets/cards/" + suit + "/" + suit + "_" + str(score) + ".png"
	#self.texture = load(texture_path)
	
	
	
