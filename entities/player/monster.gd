extends Area2D

#---Main Variables-------------------------------------------------------------------------------------------------
var velocity := Vector2(0, 0)
var normal_speed := 600.0
var boost_speed := 1500.0
var max_speed := normal_speed
var steering_factor := 10.0

@export var max_health := 100
var health = max_health
@onready var health_bar = $UI/HealthBar
@onready var ui_node = $UI

#---Movement Function----------------------------------------------------------------------------------------------
func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

#---Boost----------------------------------------------------------------------------------------------------------
	if Input.is_action_just_pressed("boost"):
		max_speed = boost_speed
		get_node("Timer").start()

#---Direction------------------------------------------------------------------------------------------------------
	if direction.length() > 1:
		direction = direction.normalized()
	if velocity.length() > 0.0:
		get_node("Sprite2D").rotation = velocity.angle()

#---Smooth Movement------------------------------------------------------------------------------------------------
	var desired_velocity := direction * max_speed
	var steering_vector := desired_velocity - velocity
	
	velocity += steering_vector * steering_factor * delta
	position += velocity * delta

#---Timer Node Function--------------------------------------------------------------------------------------------
func _on_timer_timeout() -> void:
	max_speed = normal_speed

#---Health Function------------------------------------------------------------------------------------------------
func set_health(new_health: int) -> void:
	health = new_health
	get_node("UI/HealthBar").value = health

#---Ready Function-------------------------------------------------------------------------------------------------
func _on_ready() -> void:
	set_health(health)
