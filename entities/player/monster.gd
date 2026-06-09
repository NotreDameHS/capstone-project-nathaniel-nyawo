extends Node2D

#---Main Variables-------------------------------------------------------------------------------------------------
var velocity := Vector2(0, 0)
var normal_speed := 600.0
@export var max_speed := normal_speed
var steering_factor := 10.0
var health_count := 0
@onready var cooldown: Timer = $CoolDown

@export var max_health := 100
var health = max_health
@onready var health_bar = $UI/HealthBar
@onready var ui_node = $UI

###-Mob Detection and Projectiles----------------------------------------------------------------------------------
@export var enemy_detection_range:= 500.0
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
	var enemy_in_range : Array = detection_area.get_overlapping_areas()

	if not enemy_in_range.is_empty():
		var target: Node2D = enemy_in_range[0]
		look_at(target.global_position)

#---Movement Function----------------------------------------------------------------------------------------------
func _process(delta: float) -> void:
	var direction := Vector2(0, 0)
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction.length() > 1:
		direction = direction.normalized()
	
	ui_node.rotation = -global_rotation

#---Smooth Movement------------------------------------------------------------------------------------------------
	var desired_velocity := direction * max_speed
	var steering_vector := desired_velocity - velocity
	
	velocity += steering_vector * steering_factor * delta
	position += velocity * delta

#---Shooting Projectiles-------------------------------------------------------------------------------------------
	if Input.is_action_just_pressed("acid_attack"):
		if cooldown.is_stopped():
			acid_shot()
		else:
			return

#---Shooting Function----------------------------------------------------------------------------------------------
func acid_shot():
	var projectile = projectile_scene.instantiate()

	get_tree().current_scene.add_child(projectile)

	projectile.global_transform = spawn_point.global_transform
	
	cooldown.start()

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

func set_health_count(new_health_count: int) -> void:
	health_count = new_health_count
	get_node("$UI/Healthcount").text = "x" + str(health_count)
#func _on_area_entered(area: Node2D) -> void:
	#if area.is_in_group("health"):
		#set_health_count(health_count + 1)
	#elif area.is_in_group("healing_item"):
		#set_health(health + 10)
		
		
func spawn_collectible_drop() -> void:
	var drop_scene = load("://entities/collectibles/speed_boost/speed.tscn")
	if drop_scene:
		var drop = drop_scene.instantiate()
		get_parent().call_deferred("add_child", drop)
		drop.global_postion = global_position


func _on_hit_box_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("health"):
		set_health_count(health_count + 1)
	elif area.is_in_group("healing_item"):
		set_health(health + 10)
	pass # Replace with function body.
