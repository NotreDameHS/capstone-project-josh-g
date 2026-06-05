extends Node

signal xp_changed(amount: float)

const GAME_END_SCREEN = preload("res://ui/game_end_screen.tscn")

var player_xp: int = 0
var player_max_xp: int = 50

func show_end_screen(message: String) -> void:
	var screen = GAME_END_SCREEN.instantiate()
	get_tree().current_scene.add_child(screen)
	screen.set_title(message)
	
# Called when the node enters the scene tree for the first time.

func check_upgrade(current_xp: int, area: Area2D):
	if current_xp >= player_max_xp:
		area.apply_upgrade()
		
		pass
func _ready() -> void:
	xp_changed.emit(player_xp)
	pass # Replace with function body.

func increase_strength(area1: Area2D):
	area1.strengthen()

func reward_hit(area: Area2D):
	var current = area.get_xp()
	var new = current + 10
	area.set_xp(new)
	print("Succesfully shot down object! (+10 XP, current xp: ", new, ")")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
