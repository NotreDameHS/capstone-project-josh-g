class_name MapController extends Node2D

@export var crop_scene: PackedScene
@export var min_spacing := 64.0
@onready var path_layer: TileMapLayer = get_tree().current_scene.get_node("World_1").get_node("Path")

const UPGRADE_PROMPT = preload("res://ui/upgrade_prompt.tscn")


func _on_upgrade_pressed() -> void:
	pass
	
func _find_clicked_turret(position: Vector2) -> Node:
	var placed_turrets = get_tree().get_nodes_in_group("Turrets")
	
	for turret in placed_turrets:
		
		var distance = position.distance_to(turret.global_position)
		
		if distance < min_spacing:
			return turret
			
	return null
	

	
func _has_overlapping_crop(position: Vector2) -> bool:
	
	var placed_turrets = get_tree().get_nodes_in_group("Turrets")
	
	for turret in placed_turrets:
		var distance = position.distance_to(turret.global_position)
		
		if distance < min_spacing:
			return true
			
	return false
	
	
	
func place_turret() -> void:
	var mouse_world_pos = get_global_mouse_position()
	
	if GameManager.selected_crop_scene == null:
		return
		
	if _has_overlapping_crop(mouse_world_pos):
		print("Cannot place turret too close to another!")
		return
		
	if GameManager.try_spend_money(GameManager.selected_crop_price):
		print("We have the money!")
		var new_crop = GameManager.selected_crop_scene.instantiate()
		new_crop.global_position = mouse_world_pos
		new_crop.add_to_group("Turrets")
		get_tree().current_scene.add_child(new_crop)
		GameManager.clear_selection()
		
	else:
		print("Not enough money for this turret!")

func _show_upgrade_prompt() -> void:
	
	if GameManager.selected_crop_node.is_upgraded:
		return
	
	var prompt = UPGRADE_PROMPT.instantiate()
	
	prompt.target_turret = GameManager.selected_turret_node
	
	add_child(prompt)
	
	
func _unhandled_input(event: InputEvent) -> void:
		
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		place_turret()
		var mouse_pos = get_global_mouse_position()
	
		if _has_overlapping_crop(mouse_pos) and GameManager.selected_turret_node == null:
			var clicked_turret = _find_clicked_turret(mouse_pos)
			GameManager.selected_turret_node = clicked_turret
			_show_upgrade_prompt()
			
		else:
			GameManager.selected_turret_node = null
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
