extends Area2D

var velocity := Vector2(0, 0)
var normal_speed := 600.0
var boost_speed := 1500.0
var max_speed := normal_speed
var health := 10
var score := 0


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

func _on_area_entered(area: Area2D) -> void:
		
	if area.is_in_group("health_power_up"):
		set_health(health + 10)
		
	if area.is_in_group("XP"):
		print("Placeholder")
	




func _on_timer_timeout() -> void:
	pass
