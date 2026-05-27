extends Node2D
@export var speed: float = 200.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < -600:
		queue_free()
	pass


func _on_top_pipe_body_entered(body: Node2D) -> void:
	
	pass # Replace with function body.


func _on_bottom_pipe_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
