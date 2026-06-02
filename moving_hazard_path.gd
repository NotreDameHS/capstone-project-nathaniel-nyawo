extends Path2D
@export var speed: float = 0.5
@onready var path_follow: PathFollow2D= $ PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	path_follow.progress_ratio += speed * delta
	if path_follow.progress_ratio >= 1.0:
		path_follow.progress_ratio = 0.0
