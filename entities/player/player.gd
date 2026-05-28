extends Area2D

var velocity := Vector2(0, 0)
var normal_speed := 600.0
var boost_speed := 1500.0
var max_speed := normal_speed
var health := 20
var score := 0
@export var mob_detection_range := 100.0
@onready var detection_range = $DetectionArea/CollisionShape2D
@onready var detection_area = $DetectionArea
@export var attack_rate := 1.0
@onready var timer = $Timer
@export var projectile_scene: PackedScene
@onready var spawn_point = $Marker2D
@onready var turret_sprite: Sprite2D = $TurretSprite
@export var upgrade_turret_image: CompressedTexture2D
@export var upgrade_price: float = 75.0
@export var upgrade_projectile_scene: PackedScene
@export var is_upgraded: bool = false

# Called when the node enters the scene tree for the first time.
func set_health(new_health: int) -> void:
	health = new_health
	get_node("UI/HealthBar").value = health
	
	
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	set_health(health)
	
	 # Replace with function body.

var steering_factor := 10.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var direction := Vector2(0, 0)
	
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()
		
	var desired_velocity := direction * max_speed
	var steering_vector := desired_velocity - velocity
	
	velocity += steering_vector * steering_factor * delta
	position += velocity * delta
	
	if direction.length() > 0.0:
		get_node("Sprite2D").rotation = velocity.angle()
	
	if velocity.length() > 0.0:
		get_node("Sprite2D").rotation = velocity.angle()
		
	var viewport_size := get_viewport_rect().size
	position.x = wrapf(position.x, 0, viewport_size.x)
	position.y = wrapf(position.y, 0, viewport_size.y)
	
	
func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#var mobs_in_range : Array = detection_area.get_overlapping_areas()
		
		var projectile = projectile_scene.instantiate()
		
		get_tree().current_scene.add_child(projectile)
		
		projectile.global_transform = spawn_point.global_transform
		
		

func _on_area_entered(area: Area2D) -> void:
		
	if area.is_in_group("health_power_up"):
		set_health(health + 10)
		
	if area.is_in_group("XP"):
		print("Placeholder")
		
	if area.is_in_group("Objects"):
		set_health(health - 10)
		
	if area.is_in_group("XP"):
		pass
		
	





func _on_timer_timeout() -> void:
	pass
