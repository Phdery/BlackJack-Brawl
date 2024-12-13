class_name TarotFoolCard
extends Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	description = "The Fool: add 1 to your max score. Score = 0"

func mechanism(this:Controller, other:Controller):
	this.score_card.update_max(this.score_card.max_score + 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
