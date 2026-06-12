class_name Monster extends Node2D

#---Main Variables-------------------------------------------------------------------------------------------------
var velocity := Vector2(0, 0)
var normal_speed := 600.0
@export var max_speed := normal_speed
var steering_factor := 10.0
var health_count := 0
@onready var cooldown: Timer = $CoolDown

@export var max_health := 100.0
var health = max_health
@onready var health_bar = $HitBoxArea/UI/HealthBar
@onready var ui_node = $HitBoxArea/UI
@onready var healthCount = $HitBoxArea/UI/HealthCount

###-Mob Detection and Projectiles----------------------------------------------------------------------------------
@export var enemy_detection_range:= 1000.0
@onready var detection_range := $MobDetection/CollisionShape2D
@onready var detection_area = $MobDetection
@export var attack_rate := 1.5
var normal_attack_rate = attack_rate
@onready var timer = $Timer
@export var projectile_scene: PackedScene
@onready var spawn_point = $Marker2D
var is_powerup_acitve := false

#---Ready Function-------------------------------------------------------------------------------------------------
func _ready() -> void:
	health_bar.max_value = max_health
	
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
	
	global_position.x = clamp(global_position.x, -2168, 2168)
	global_position.y = clamp(global_position.y, -2168, 2168)

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
	if is_powerup_acitve:
		cooldown.start(0.05)
	else:
		cooldown.start(0.4)

#---Timer Node Function--------------------------------------------------------------------------------------------
func _on_timer_timeout() -> void:
	max_speed = normal_speed
	
	#if attack_rate > normal_attack_rate:
		#attack_rate = normal_attack_rate
		#timer.wait_time = 1.0 / attack_rate
		#timer.start()
	

#---Health Function------------------------------------------------------------------------------------------------
func set_health(new_health: int) -> void:
	health = new_health
	get_node("HitBoxArea/UI/HealthBar").value = health

#---Ready Function-------------------------------------------------------------------------------------------------
func _on_ready() -> void:
	set_health(health)

func set_health_count(new_health_count: int) -> void:
	health_count = new_health_count
	healthCount.text = "x" + str(health_count)


#func _on_area_entered(area: Node2D) -> void:
	#if area.is_in_group("health"):
		#set_health_count(health_count + 1)
	#elif area.is_in_group("healing_item"):
		#set_health(health + 10)
		
		
func activate_lightning_boost() -> void:
	print("speed boost activated!")
	is_powerup_acitve = true
	max_speed = normal_speed * 1.5
	await get_tree().create_timer(5.0).timeout
	print("speed boost done")
	is_powerup_acitve = false
	max_speed = normal_speed

#---Damage Function------------------------------------------------------------------------------------------------
func _take_damage(amount: float) -> void:
	if cooldown.is_stopped():
		print("You're taking ", amount, " damage!")
		health -= amount
		if health <= 0.0:
			if health_count > 0:
				set_health_count(health_count - 1)
				health = max_health
				print("lost a life! Remaining Lives: ", health_count)
			else:
				health = 0.0
				GameManager.show_end_screen("Game Over!\nFinal Score: " + str(GameManager.score))
		if health_bar:
			print(health)
			health_bar.value = health
	else:
		return
	cooldown.start()

#---Area Entered Function------------------------------------------------------------------------------------------
func _on_hit_box_area_area_entered(area: Area2D) -> void:
	print("In area")
	if area.is_in_group("speed_boost"):
		activate_lightning_boost()
		area.queue_free()
	if area.is_in_group("healing_item"):
		print("In heal")
		if health_count < 4:
			set_health_count(health_count + 1)
		set_health(health + 10)

		print("area1")
	pass # Replace with function body.
