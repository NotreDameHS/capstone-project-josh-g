class_name Missile extends Area2D

@export var max_distance := 900.0
@export var speed := 300.0
@export var damage := 25
var _distance_traveled := 0.0
var direction := Vector2.RIGHT
	
func _explode() -> void:
	spawn_poof(global_position)
	queue_free()
	
func upgrade_missile():
	speed += 10
	damage += 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	_distance_traveled += speed * delta
	
	if _distance_traveled > max_distance:
		_explode()
	
	
	pass



func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	
	if area is Objects:
		area._take_damage(damage)
		_explode()
		
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
