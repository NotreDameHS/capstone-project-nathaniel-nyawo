class_name Enemy extends Area2D
@export var chase_speed: float = 120.0 
@export var damage_amount: float = 10.0
var is_chasing: bool = false



###-Health Variables-------------------------------------------------------------------------
@export var max_health := 200.0
@export var health = max_health
@onready var health_bar = $UI/HealthBar
@onready var ui_node = $UI

#---On Ready---------------------------------------------------------------------------------
func _on_ready() -> void:
	health = max_health
	if health_bar:
		
		health_bar.max_value = max_health
		health_bar.value = health
	
#---Taking Damage----------------------------------------------------------------------------
func _take_damage(amount: float) -> void:
	health -= amount
	if health <= 0.0:
		GameManager.add_score(15)
		spawn_collectible_drop()
		health = 0.0
		queue_free()
	if health_bar:
		health_bar.value = health

func spawn_collectible_drop() -> void:
	var drop_scene = load("://entities/collectibles/speed_boost/speed.tscn")
	if drop_scene:
		var drop = drop_scene.instantiate()
		get_parent().call_deferred("add_child", drop)
		drop.global_postion = global_position

func _physics_process(delta: float) -> void:
	var player = get_tree().current_scene.get_node_or_null("Monster")
	
	ui_node.rotation = -global_rotation

	if player:
		var direction = global_position.direction_to(player.global_position)
		

func _on_area_entered(area: Node2D) -> void:
	if area.name == "Monster":
		if area.has_method("take_damage"):
			area.take_damage(damage_amount)
		queue_free()
