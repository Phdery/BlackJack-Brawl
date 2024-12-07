class_name Card
extends Sprite2D

# Every card must has a score
@export var score:int
@export var description = "This is my description\nhi there"

#TODO make machanism for different cards
# based on special effect, set bool var to true when card created
# keep other bool var false
# when you call mechanism, only the correct effect will trigger
func mechanism(this:Controller, other:Controller):
	pass

#TODO some other helper function

# func for setting texture so that it's different for each card?
