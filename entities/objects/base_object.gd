class_name Objects extends Area2D

@export var speed := 300.0
@export var max_distance := 900.0
@export var max_health := 100
@export var health := max_health
@export var damage := 25
@onready var health_bar = $UI/HealthBar
var _distance_traveled := 0.0
var direction := Vector2.RIGHT

func strengthen():
	speed += 10
	max_health += 10
	damage += 10
	
	
func _take_damage(amount: float) -> void: 
	var tbd : float = health_bar.value
	
	var new : float = tbd - amount
	
	if new == 0:
		health_bar.value = 0
		queue_free()
	
	elif new > 0:
		health_bar.value = new
		
	if health <= 0:
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Objects")
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health

	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	position += transform.y * speed * delta
	_distance_traveled += speed * delta
	
	if _distance_traveled > max_distance:
		queue_free()

func spawn_poof(projectile_position: Vector2):
	var particles = CPUParticles2D.new()
	
	get_tree().current_scene.add_child(particles)
	
	particles.global_position = projectile_position
	
	# Create a particle cloud (a "poof" of particles from the center)
	particles.z_index = 100 
	particles.z_as_relative = false 
	particles.amount = 20
	particles.lifetime = 0.5
	particles.explosiveness = 1.0
	particles.one_shot = true
	particles.scale_amount_min = 10.0 
	particles.scale_amount_max = 20.0
	particles.spread = 180.0
	particles.gravity = Vector2(0, 0)
	particles.initial_velocity_min = 80.0
	particles.initial_velocity_max = 150.0
	particles.damping_min = 50.0 

	# Design the shape of the cloud (the "poof")
	var curve = Curve.new()
	curve.add_point(Vector2(0, 1.0)) 
	curve.add_point(Vector2(1, 0.0))
	particles.scale_amount_curve = curve

	# Design the colours of the cloud
	var gradient = Gradient.new()
	gradient.add_point(0.0, Color(1, 1, 1, 1)) 
	gradient.add_point(1.0, Color(1, 1, 1, 0)) 
	particles.color_ramp = gradient
	
	particles.emitting = true
	
	var timer = get_tree().create_timer(particles.lifetime + 0.5)
	timer.timeout.connect(particles.queue_free)
	
func _on_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("player"):
		area._player_take_damage(damage)
		spawn_poof(global_position)
		queue_free()
	
	
