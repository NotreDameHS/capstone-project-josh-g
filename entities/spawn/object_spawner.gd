extends Node2D

@export var object_types: Array[PackedScene]
@export var objects_per_wave: int = 15
@export var spawn_delay: float = 0.5
@export var wave_delay: float = 10.0

@export var damage := 25
@onready var timer: Timer = $Timer
var current_wave: int = 0
var spawned_in_wave: int = 0

func start_new_wave():
	current_wave += 1
	print("Starting Wave: ", current_wave)
	spawned_in_wave = 0
	timer.wait_time = spawn_delay
	timer.start()

	pass


func spawn_mob():
	if object_types.is_empty():
		return
	var random_object_scene = object_types.pick_random()
	
	var new_object = random_object_scene.instantiate()
	
	add_child(new_object)
	
	var viewport_size := get_viewport_rect().size
	
	var random_position := Vector2(0.0, 0.0)
	random_position.x = randf_range(0.0, viewport_size.x)
	random_position.y = randf_range(viewport_size.y - 800, viewport_size.y - 800)
	
	new_object.position = random_position
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	start_new_wave()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass

func prepare_next_wave():
	await get_tree().create_timer(wave_delay).timeout
	start_new_wave()

func _on_timer_timeout() -> void:
	
	if spawned_in_wave < objects_per_wave:
		spawn_mob()
		spawned_in_wave += 1
	
	if spawned_in_wave >= objects_per_wave:
		timer.stop()
		prepare_next_wave()
		pass
