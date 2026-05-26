extends Node

const GAME_END_SCREEN = preload("res://ui/game_end_screen.tscn")
	

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.
	
func show_end_screen(message: String) -> void:
	var screen = GAME_END_SCREEN.instantiate()
	get_tree().current_scene.add_child(screen)
	screen.set_title(message)
	

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
