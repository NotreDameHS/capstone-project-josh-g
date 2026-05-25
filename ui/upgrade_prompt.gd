extends CanvasLayer

var target_crop: Node = null

func _on_upgrade_pressed() -> void:
	if GameManager.try_spend_money(target_crop.upgrade_price):
		
		target_crop.apply_upgrade()
		
	else:
		print("Not enough money!")
		
	queue_free()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var prompt_btn = $PanelContainer/Button
	
	if target_crop and target_crop.has_method("get_upgrade_price"):
		var upgrade_cost = target_crop.get_upgrade_price()
		prompt_btn.text = "Upgrade $" + str(int(upgrade_cost))
		
		var screen_pos = target_crop.get_global_transform_with_canvas().origin
		
		offset = screen_pos + Vector2(-40, -80)
		
		var ui_size = $PanelContainer.get_rect().size
		offset.x -= ui_size.x / 2
		
	prompt_btn.pressed.connect(_on_upgrade_pressed)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
