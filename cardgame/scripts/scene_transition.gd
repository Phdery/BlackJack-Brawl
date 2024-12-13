extends CanvasLayer


@onready var transition_color: ColorRect = $TransitionColor


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition_color.color.a = 0


func change_scene_smooth(path: String) -> void:
	var tree := get_tree()
	
	var animation_on := create_tween()
	animation_on.tween_property(transition_color, "color:a", 1, 0.5)
	await animation_on.finished
	
	tree.change_scene_to_file(path)
	
	var animation_out = create_tween()
	animation_out.tween_property(transition_color, "color:a", 0, 0.5)
	await animation_out.finished


func new_game() -> void:
	change_scene_smooth("res://scenes/select_menu.tscn")
