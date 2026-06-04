extends CharacterBody2D
@export var speed: float = 100.0 

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var player = get_parent().get_node_or_null("monster")
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
