class_name UnoStopCard
extends Card


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 5
	description = "Stop Card\n Score = 5 \n end enemy's turn. "
	# set texture
	

func mechanism(this:Controller, other:Controller):
	# change some bool that ends other's turn
	other.is_stopped = true
	
