extends Node2D

@onready var label: Label = $TextLabel
@onready var label2: Label = $TextLabel2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var delay: float = 3.0
	SoundManager.stop_all_sfx()
	await get_tree().create_timer(delay).timeout
	SoundManager.play_story(preload("res://assets/sfx/background_story.mp3"))
	label.text = "Congratulations, now you successfully"
	label2.text = "registered Gaming Playing course"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
