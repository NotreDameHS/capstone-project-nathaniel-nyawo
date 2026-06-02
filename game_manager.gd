extends Node2D
signal score_changed(new_score: int)
signal player_died
var score: int = 0
func add_score(amount: int) -> void:
	score += amount
	score_changed.emit(score)

func reset_game() -> void:
	score = 0
	get_tree().reload_current_scene()
	
func notfiy_player_death() -> void:
	player_died.emit()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
