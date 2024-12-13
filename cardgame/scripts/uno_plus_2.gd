class_name UnoPlus2
extends Card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 2
	description = "+2: 2 points to enemy total. Score = 2"
	# set texture
	
func mechanism(this:Controller, other:Controller):
	other.score_card.update_score(other.score_card.current_score + 2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
