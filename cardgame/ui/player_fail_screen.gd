extends CanvasLayer

@onready var label_1: Label = $Label
@onready var label_2: Label = $Label2

var label_1_size: float = 1.0
var label_2_size: float = 1.0

const LABEL1_START_SIZE = 1
const LABEL1_END_SIZE = 3800
const LABEL1_DURATION = 5.0
const LABEL2_START_DELAY = 2.0
const LABEL2_START_SIZE = 1
const LABEL2_END_SIZE = 36
const LABEL2_DURATION = 5.0

func _ready() -> void:
	hide()
	label_1.hide()
	label_2.hide()
	#label_1.add_theme_font_size_override("Font Sizes", LABEL1_START_SIZE)
	#label_2.add_theme_font_size_override("Font Sizes", LABEL2_START_SIZE)
	

func start_animation():
	label_1.show()
	label_2.show()

	# Do the animation of the size
	#var tween = get_tree().create_tween()
	#tween.tween_property(self, "label_1_size", LABEL1_END_SIZE, LABEL1_DURATION).from(LABEL1_START_SIZE)
	## Do the animation for label 2
	#await get_tree().create_timer(2).timeout
	#var tween_2 = get_tree().create_tween()
	#tween_2.tween_property(self, "label_2_size", LABEL2_END_SIZE, LABEL2_DURATION).from(LABEL2_START_SIZE)


func start_label2_animation():
	var tween2 = get_tree().create_tween()
	tween2.tween_property(self, "label_2_size", LABEL2_END_SIZE, LABEL2_DURATION).from(LABEL2_START_SIZE)


func _process(delta: float) -> void:
	# Change sizes
	label_1.add_theme_font_size_override("Font Sizes", int(label_1_size))
	label_2.add_theme_font_size_override("Font Sizes", int(label_2_size))


func _on_button_pressed() -> void:
	GameGlobal.game_state = GameGlobal.GameState.PLAYER_FAIL
	get_tree().change_scene_to_file("res://ui/end_screen.tscn")
