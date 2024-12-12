extends Button

@onready var deck = $".."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	print("hi there")
	deck.exit_scene()


func _on_mouse_entered() -> void:
	print("Hovering over button")
