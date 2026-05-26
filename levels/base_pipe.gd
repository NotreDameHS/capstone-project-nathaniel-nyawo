extends Area2D
@onready var target_path: Path2D
@export var mob_types : Array[PackedScene]
#---Physics Process Function-------------------------------------------
func _physics_process(delta: float) -> void:
	if get_parent() is PathFollow2D:
		if get_parent().progress_ratio >= 1.0:
			queue_free()
