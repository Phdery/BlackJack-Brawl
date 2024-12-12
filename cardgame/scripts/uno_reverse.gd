class_name UnoReverse
extends Card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 5
	description = "Swap scores with enemy. Score = 5"
	# set texture

func mechanism(this:Controller, other:Controller):
	var this_score = this.score_card.current_Score
	var other_score = other.score_card.current_score
	this.score_card.update_score(other_score)
	other.score_card.update_Score(this_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
