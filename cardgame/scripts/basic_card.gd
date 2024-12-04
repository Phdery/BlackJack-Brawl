class_name BasicCard
extends Card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _init(new_score:int, new_suit:String) -> void:
	score = new_score
	suit = new_suit
	var texture_path:String = "res://assets/" + suit + "_" + str(score) + ".png"
	self.texture = load(texture_path)
