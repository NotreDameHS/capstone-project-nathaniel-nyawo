extends Node2D
@export var enemy_scene: PackedScene
@onready var spawn_timer: Timer = $enemyspawntimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_over_triggered.connect(_on_game_over)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemyspawntimer_timeout() -> void:
	if not enemy_scene:
		return
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	$"spawn path/PathFollow2D".progress_ratio = randf()
	new_enemy.global_position = $"spawn path/PathFollow2D".global_position

func _on_game_over() -> void:
	spawn_timer.stop()
