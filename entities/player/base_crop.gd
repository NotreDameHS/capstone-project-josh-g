class_name Crop extends Node2D
@export var crop_detection_range := 100.0
@onready var detection_range = $DetectionArea/CollisionShape2D
@onready var detection_area = $DetectionArea
@onready var spawn_point = $Marker2D
@onready var timer = $Timer
@onready var crop_sprite: Sprite2D = $CropSprite
@export var upgrade_crop_image: CompressedTexture2D
@export var upgrade_price: float = 75.0
@export var is_upgraded: bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(detection_range.shape.radius)
	detection_range.shape = detection_range.shape.duplicate()
	detection_range.shape.radius = crop_detection_range
	print(detection_range.shape.radius)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_upgrade_price() -> float:
	return upgrade_price
	
func apply_upgrade() -> void:
	is_upgraded = true
	
	crop_sprite.texture = upgrade_crop_image
	
	print("Crop successfully upgraded!")

func _on_timer_timeout() -> void:
	pass
