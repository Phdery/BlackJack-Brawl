class_name StatusCard
extends Control


@export var current_hp:int = 100
@export var max_hp:int = 100
@onready var label = $CenterContainer/Label


#TODO animasion to show the score

#TODO some other helper function
func _ready() -> void:
	label.visible = true
	label.text = "HP = " + str(current_hp) + " / " + str(max_hp)
	update_hp(80)
	
	
func update_hp(new_hp:int) -> void:
	# Ensure current_hp does not exceed max_hp
	current_hp = clamp(new_hp, 0, max_hp)
	label.text = "HP = " + str(current_hp) + " / " + str(max_hp)


func update_max(new_max:int) -> void:
	max_hp = new_max
	label.text = "HP = " + str(current_hp) + " / " + str(max_hp)
	
