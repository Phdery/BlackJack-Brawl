class_name UnoPlus2
extends Card


# Called when the node enters the scene tree for the first time.
func init() -> void:
	score = 2
	description = "+2 Card\n Score = 2 \n add 2 points to enemy's score. "
	# set texture
	
	
func mechanism(this:Controller, other:Controller):
	other.score_card.update_score(other.score_card.current_score + 2)
	other.extra_points += 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
