extends CanvasLayer

@onready var pause_btn: Button = $TopMargin/HBoxContainer/PauseBtn

#---Ready Function---------------------------------------------------------------------------
func _ready() -> void:
	pause_btn.pressed.connect(_on_pause_pressed)

#---Pause Function---------------------------------------------------------------------------
func _on_pause_pressed() -> void:
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	
	if get_tree().paused:
		pause_btn.text = "Resume"
	else:
		pause_btn.text = "Pause"
