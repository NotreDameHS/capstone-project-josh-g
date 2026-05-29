extends Node2D

@onready var target_path: Path2D
@export var mob_types: Array[PackedScene]
@export var mobs_per_wave: int = 5
@export var spawn_delay: float = 0.5
@export var wave_delay: float = 10.0
@export var total_waves: int = 7

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
	if mob_types.is_empty() or target_path == null:
		return
	
	var random_mob_scene = mob_types.pick_random()
	
	var new_mob = random_mob_scene.instantiate()
	
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var path_node = get_tree().current_scene.get_node_or_null("Path2D")
	
	if path_node:
		target_path = path_node
		
	else:
		process_mode = Node.PROCESS_MODE_DISABLED
		
	start_new_wave()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func prepare_next_wave():
	await get_tree().create_timer(wave_delay).timeout
	start_new_wave()

func _on_timer_timeout() -> void:
	
	if spawned_in_wave < mobs_per_wave:
		spawn_mob()
		spawned_in_wave += 1
	
	if spawned_in_wave >= mobs_per_wave:
		timer.stop()
		prepare_next_wave()
		pass
