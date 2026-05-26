extends Node2D
@onready var target_path: Path2D
@export var mob_types : Array[PackedScene]
var path_follower_script = preload()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
