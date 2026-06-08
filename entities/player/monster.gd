class_name Enemy extends Area2D

#---Main Variables-------------------------------------------------------------------------------------------------
var velocity := Vector2(0, 0)
var normal_speed := 600.0
@export var max_speed := normal_speed
var steering_factor := 10.0

@export var max_health := 100
var health = max_health
@onready var health_bar = $UI/HealthBar

###-Mob Detection and Projectiles----------------------------------------------------------------------------------
@export var enemy_detection_range:= 100.0
@onready var detection_range := $MobDetection/CollisionShape2D
@onready var detection_area = $MobDetection
@export var attack_rate := 1.5
@onready var timer = $Timer
@export var projectile_scene: PackedScene
@onready var spawn_point = $Marker2D

#---Ready Function-------------------------------------------------------------------------------------------------
func _ready() -> void:
	detection_range.shape = detection_range.shape.duplicate()
	detection_range.shape.radius = enemy_detection_range
	
	timer.wait_time = 1.0 / attack_rate
	timer.start()

#---Mob Aim/Physics Process Function-------------------------------------------------------------------------------
func _physics_process(_delta) -> void:
	var enemies = get_tree().get_nodes_in_group("mobs")
	var enemy_in_range : Array = detection_area.get_overlapping_areas()
	if not enemy_in_range.is_empty():
		var target: Area2D = enemy_in_range[0]
		look_at(target.global_position)

#---Movement Function----------------------------------------------------------------------------------------------
func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

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

#---Shooting Projectiles-------------------------------------------------------------------------------------------
	var enemy_in_range : Array = detection_area.get_overlapping_areas()
	
	if enemy_in_range.is_empty():
		return
	
	if Input.is_action_just_pressed("acid_attack"):
		var projectile = projectile_scene.instantiate()

		get_tree().current_scene.add_child(projectile)

		projectile.global_transform = spawn_point.global_transform

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
