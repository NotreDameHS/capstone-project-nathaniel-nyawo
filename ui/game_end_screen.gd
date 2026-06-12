extends CanvasLayer


@onready var title_label : Label = $CenterContainer/TitleLable

#---Title Set Function-----------------------------------------------------------------------
func set_title(text: String) -> void:
	title_label.text = text

#---Ready Function---------------------------------------------------------------------------
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().paused = false
		GameManager.reser_game()
