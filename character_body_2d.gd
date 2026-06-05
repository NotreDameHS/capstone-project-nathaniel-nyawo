extends CharacterBody2D
@export var path_speed: float = 0.2
@export var chase_speed: float = 120.0 
var is_chasing: bool = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	var player = get_tree().current_scene.get_node_or_null("Monster")
	
	
	
	
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * chase_speed
		move_and_slide()
