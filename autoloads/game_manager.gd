extends Node
signal score_changed(new_score: int)
signal wave_changed(new_wave: int)

var score: int = 0
var current_wave: int = 1
func add_score(amount: int) -> void:
	score += amount
	score_changed.emit(score)
	
func advance_wave() -> void:
	current_wave += 1
	wave_changed.emit(current_wave)

func reser_game() -> void:
	score = 0
	get_tree().reload_current_scene()
	
func trigger_game_over() -> void:
	score = 0
	current_wave = 1
	print("GAME OVER: RESTARTING STAGE")
	get_tree().reload_current_scene()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
