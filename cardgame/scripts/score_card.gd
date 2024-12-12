class_name ScoreCard

extends Control

var current_score:int = 0
var max_score:int = 21
@onready var label = $CenterContainer/Label

#TODO animasion to show the score


#TODO some other helper function
func _ready() -> void:
	label.visible = true
	label.text = "Total = " + str(current_score) + " / " + str(max_score)


func update_score(new_score:int) -> void:
	current_score = new_score
	label.text = "Total = " + str(current_score) + " / " + str(max_score)

func update_max(new_max:int) -> void:
	max_score = new_max
	label.text = "Total = " + str(current_score) + " / " + str(max_score)
