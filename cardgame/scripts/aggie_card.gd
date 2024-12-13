class_name AggieCard
extends Card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 5
	description = "Aggie Card\n Score = 5 \n  gain 5 HP. "

	
func mechanism(this:Controller, other:Controller):
	this.status_card.update_hp(this.status_card.current_hp + 5)
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
