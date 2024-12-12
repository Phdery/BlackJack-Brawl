class_name UnoStopCard
extends Card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 5
	description = "End enemy's turn. Score = 5"
	# set texture
	

func mechanism(this:Controller, other:Controller):
	# change some bool that ends other's turn
	other.is_stopped = true
	
