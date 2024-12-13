class_name JokerCard
extends Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 5
	description = "Joker: deal random damage 1-10 to enemy. Score = 5"
	# set texture
	
func mechanism(this:Controller, other:Controller):
	randomize()
	var damage = randi_range(1,10)
	other.status_card.update_hp(other.status_card.current_hp - damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
