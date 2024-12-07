class_name Card
extends Sprite2D

# Every card must has a score
@export var score:int
@export var description = "This is my description\nhi there"
@export var special_effect_1:bool = false
@export var special_effect_2:bool = false
@export var special_effect_3:bool = false

#TODO make machanism for different cards
# based on special effect, set bool var to true when card created
# keep other bool var false
# when you call mechanism, only the correct effect will trigger
func mechanism(this:Controller, other:Controller):
	if special_effect_1:
		pass
	elif special_effect_2:
		pass
	elif special_effect_3:
		pass
	else: # regular card, no effect
		pass

#TODO some other helper function

# func for setting texture so that it's different for each card?
