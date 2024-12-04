class_name StatusCard

extends Node2D

@export var current_hp:int = 100
@export var max_hp:int = 100
@onready var label = $"../Label"

#TODO animasion to show the score

#TODO some other helper function
func _ready() -> void:
	label.visible = true
	label.text = "HP = " + str(current_hp) + " out of " + str(max_hp)

func update_hp(new_hp:int) -> void:
	current_hp = new_hp
	label.text = "HP = " + str(current_hp) + " out of " + str(max_hp)

func update_max(new_max:int) -> void:
	max_hp = new_max
	label.text = "HP = " + str(current_hp) + " out of " + str(max_hp)
	
