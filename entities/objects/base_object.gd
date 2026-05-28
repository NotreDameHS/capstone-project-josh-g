class_name Objects extends Area2D

@export var speed := 100.0
@onready var ui_node = $UI

func _take_damage(amount: float) -> void: 
	#GameManager.give_xp(10.0)
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Objects")

	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
