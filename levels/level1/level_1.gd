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
	var new_path_follower = PathFollow2D.new()
	new_path_follower.loop = false
	$"spawn path".add_child(new_path_follower)
	new_path_follower.progress_ratio = randf()
	var new_enemy = enemy_scene.instantiate()
	new_path_follower.add_child(new_enemy)
func _on_game_over() -> void:
	spawn_timer.stop()
