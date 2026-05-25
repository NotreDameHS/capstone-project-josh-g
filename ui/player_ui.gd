extends CanvasLayer

@onready var money_label: Label = $MarginContainer/HBoxContainer/MoneyPanel/MoneyLabel

@onready var crop_1_btn: Button = $MarginContainer/HBoxContainer/ShopPanel/Crop1/StdTurretBtn
@onready var crop_1_price_label: Label = $MarginContainer/HBoxContainer/ShopPanel/Crop1/StdTurretPrice
@onready var crop_2_btn: Button = $MarginContainer/HBoxContainer/ShopPanel/Crop2/RocketTurrettBtn
@onready var crop_2_price_label: Label = $MarginContainer/HBoxContainer/ShopPanel/Crop2/RocketTurretPrice

@export var crop_1: PackedScene
@export var crop_2: PackedScene

@onready var pause_btn: Button = $BottomMargin/HBoxContainer/PauseBtn


# Called when the node enters the scene tree for the first time.

func _on_money_changed(amount: float) -> void: 
	money_label.text = "$" + str(int(amount))

func _on_turret1_clicked() -> void:
	GameManager.select_crop(crop_1, 150)
	print("Crop 1 Clicked")
	
func _on_turret2_clicked() -> void:
	GameManager.select_crop(crop_2, 250)
	print("Crop 2 Clicked")
	

func _ready() -> void:
	
	crop_1_price_label.text = "$" + str(GameManager.crop_1_price)
	crop_2_price_label.text = "$" + str(GameManager.crop_2_price)
	
	GameManager.money_changed.emit(_on_money_changed)
	
	crop_1_btn.pressed.connect(_on_turret1_clicked)
	crop_2_btn.pressed.connect(_on_turret2_clicked)
	
	pause_btn.pressed.connect(_on_pause_pressed)
	
	pass # Replace with function body.
	
func _on_pause_pressed() -> void:
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	
	if get_tree().paused:
		pause_btn.text = "Resume"
		
	else:
		pause_btn.text = "Pause"
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
