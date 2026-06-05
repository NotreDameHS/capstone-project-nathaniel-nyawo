extends Node
signal score_changed(new_score: int)
signal game_over_triggered

var score: int = 0

func add_score(amount: int) -> void:
	score += amount
	score_changed.emit(score)
	
func reser_game() -> void:
	score = 0
	get_tree().reload_current_scene()
	
func trigger_game_over() -> void:
	game_over_triggered.emit()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
