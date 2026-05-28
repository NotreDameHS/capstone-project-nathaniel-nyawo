extends Node2D
@onready var spawn_point = $spawn_point
@export var pipe_scene : PackedScene
@onready var timer = $spawn_point/Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var new_pipe = pipe_scene.instantiate()
	add_child(new_pipe)
	new_pipe.global_position.x = spawn_point.global_position.x
	new_pipe.global_position.y = randf_range(200, 500)
	
	pass # Replace with function body.


func _on_ground_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.


func _on_ground_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
