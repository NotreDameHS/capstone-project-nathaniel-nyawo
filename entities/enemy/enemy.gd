class_name Enemy extends Area2D
@export var base_speed: float = 300.0 
@export var damage_amount: float = 100.0
var is_chasing: bool = false
var speed: float
###-Health Variables-------------------------------------------------------------------------
@export var max_health := 100.0
@export var health = max_health
@onready var health_bar = $UI/HealthBar
@onready var ui_node = $UI

#---Health Function--------------------------------------------------------------------------
func set_health(new_health: int) -> void:
	health = new_health
	get_node("UI/HealthBar").value = health

#---On Ready Function------------------------------------------------------------------------
func _on_ready() -> void:
	
	health = max_health
	if health_bar:
		
		health_bar.max_value = max_health
		health_bar.value = health
	
#---Taking Damage Function-------------------------------------------------------------------
func _take_damage(amount: float) -> void:
	health -= amount
	if health <= 0.0:
		GameManager.add_score(15)
		health = 0.0
		queue_free()
	if health_bar:
		health_bar.value = health

#---Physics Process Damage-------------------------------------------------------------------
func _physics_process(delta: float) -> void:
	var player = get_tree().current_scene.get_node_or_null("Monster")
	
	ui_node.rotation = -global_rotation

	if player:
		var direction = global_position.direction_to(player.global_position)
		position += direction * base_speed * delta

#---Area Entered Damage----------------------------------------------------------------------
func _on_area_entered(area: Node2D) -> void:
	if area.get_parent() is Monster:
		if area.get_parent().has_method("_take_damage"):
			area.get_parent()._take_damage(damage_amount)
		
