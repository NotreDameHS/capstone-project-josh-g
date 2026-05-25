extends Node

signal money_changed(amount: float)

var player_money: float = 450.0

var crop_1_price: int = 150
var crop_2_price: int = 250

var selected_crop_scene: PackedScene = null
var selected_crop_price: float = 0.0

var selected_crop_node: Node = null

const GAME_END_SCREEN = preload("res://ui/game_end_screen.tscn")
	

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	money_changed.emit(player_money)
	pass # Replace with function body.
	
func show_end_screen(message: String) -> void:
	var screen = GAME_END_SCREEN.instantiate()
	get_tree().current_scene.add_child(screen)
	screen.set_title(message)
	
func give_money(amount: float) -> void:
	player_money += amount
	money_changed.emit(player_money)
	
func try_spend_money(amount: float) -> bool:
	
	if player_money >= amount:
		player_money -= amount
		money_changed.emit(player_money)
		return true
	
	return false
	
func select_crop(scene: PackedScene, price: float) -> void:
	print(price, scene)
	selected_crop_scene = scene
	selected_crop_price = price
	
func clear_selection() -> void:
	selected_crop_scene = null
	selected_crop_price = 0.0
	

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
