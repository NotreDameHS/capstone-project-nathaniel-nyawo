extends Node2D
@export var enemy_scene: PackedScene
@export var max_enemies : int = 10
@onready var spawn_timer: Timer = $enemyspawntimer
var total_spawned_this_wave: int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemyspawntimer_timeout() -> void:
	if not enemy_scene:
		return
	var wave_limit = max_enemies + (GameManager.current_wave * 5)
	if total_spawned_this_wave >= wave_limit:
		var alive_mobs = get_tree().get_nodes_in_group("mobs").size()
		if alive_mobs == 0:
			total_spawned_this_wave = 0
			GameManager.advance_wave()
		return
	var current_enemy_count = get_tree().get_nodes_in_group("mobs").size()
	if current_enemy_count >= max_enemies:
		return
	var new_enemy = enemy_scene.instantiate()
	new_enemy.add_to_group("mobs")
	$"spawn path/PathFollow2D".progress_ratio = randf()
	new_enemy.global_position = $"spawn path/PathFollow2D".global_position
	add_child(new_enemy)
	total_spawned_this_wave += 1
	
func _on_game_over() -> void:
	spawn_timer.stop()
