extends CanvasLayer

@onready var pause_btn: Button = $TopMargin/HBoxContainer/PauseBtn
@onready var score: Label = $TopMargin/HBoxContainer/ScorePanel/ScoreLabel
@onready var score_label: Label = $TopMargin/HBoxContainer/Label


#---Ready Function---------------------------------------------------------------------------
func _ready() -> void:
	pause_btn.pressed.connect(_on_pause_pressed)
	GameManager.score_changed.connect(_on_score_changed)

func _on_score_changed(amount: float) -> void:
	score.text = str(int(amount))
	
#---Pause Function---------------------------------------------------------------------------
func _on_pause_pressed() -> void:
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	
	if get_tree().paused:
		pause_btn.text = "Resume"
	else:
		pause_btn.text = "Pause"
