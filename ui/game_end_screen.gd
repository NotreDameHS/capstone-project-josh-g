extends CanvasLayer

@onready var title_label: Label = $CenterContainer/TitleLabel

func set_title(text: String) -> void:
	title_label.text = text
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
