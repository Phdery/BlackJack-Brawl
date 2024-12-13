class_name UnoReverse
extends Card


# Called when the node enters the scene tree for the first time.
func init() -> void:
	score = 5
	description = "Reverse Card\n Score = 5 \n swap scores with enemy. "
	# set texture


func mechanism(this:Controller, other:Controller):
	var this_score = this.score_card.current_score
	var other_score = other.score_card.current_score
	this.score_card.update_score(other_score)
	other.score_card.update_score(this_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
