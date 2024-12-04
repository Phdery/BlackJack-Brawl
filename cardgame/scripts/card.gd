class_name Card
extends Node2D

# Every card must has a score
@export var score:int
@export var description:String
@export var suit:String

#TODO make machanism for different cards
func mechanism(this:Controller, other:Controller):
	pass

#TODO some other helper function
